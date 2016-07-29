package welink.user

import grails.orm.PagedResultList
import org.apache.poi.hssf.usermodel.HSSFCell
import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import pl.touk.excel.export.WebXlsxExporter
import welink.common.ConsigneeAddr
import welink.estate.Community

import static com.google.common.base.Preconditions.checkNotNull


class ProfileController {

    static Logger logger = LoggerFactory.getLogger(ProfileController)

    def exportCommunityProfile() {
        def communityName
        def address = ''
        Long communityId = params.long('communityId')

        LinkedList<ConsigneeAddr> uplist

        LinkedList<Profile> profileList

        if (communityId) {

            uplist = ConsigneeAddr.findAllByCommunityId(communityId)

            def idlist = uplist*.userId

            profileList = Profile.withCriteria {
                'in'("id", idlist)
            }
        } else {

            profileList = Profile.findAll()

        }

        List<CommunityTenant> profiles = new ArrayList<CommunityTenant>();

        profileList.iterator().each {
            Profile profile ->
                def profileInfo = ConsigneeAddr.findByUserId(profile.id)

                if (!profileInfo) {
                    address = '无地址'

                    communityName = '无购买记录'

                } else {

                    communityName = Community.findById(profileInfo.communityId).name

                    address = profileInfo.receiverAddress

                }
                profiles.add(new CommunityTenant(communityName: communityName,
                        mobile: profile.mobile,
                        registerTime: profile.dateCreated.toString().substring(0, 16),
                        address: address))
        }

        creaUsersExcel(profiles)

//        def headers = ['小区名', '手机号', '注册时间', '收货地址']
//
//        def withProperties = ['communityName', 'mobile', 'registerTime', 'address']
//
//        new WebXlsxExporter().with {
//            setResponseHeaders(response)
//            fillHeader(headers)
//            add(profiles, withProperties)
//            save(response.outputStream)
//        }




    }



    //使用的Poi来进行打印Excel
    def creaUsersExcel(List<CommunityTenant> profiles)
    {
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("用户信息");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("小区名");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("手机号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("注册时间");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("收货地址");
        cell.setCellStyle(style);

        for (int i=0;i<profiles.size();i++)
        {
            row = sheet.createRow((int) i + 1);
            CommunityTenant ct=profiles.get(i);
            row.createCell((short) 0).setCellValue(ct.communityName);
            row.createCell((short) 1).setCellValue(ct.mobile);
            row.createCell((short) 2).setCellValue(ct.registerTime);
            row.createCell((short) 3).setCellValue(ct.address);
        }

        // 第六步，将文件存到指定位置
        try
        {
            String path=request.getSession().getServletContext().getRealPath("")
            UUID uuid = UUID.randomUUID()
            FileOutputStream fout = new FileOutputStream(path+"\\"+uuid+".xls");
            wb.write(fout);
            fout.close();


            //提供进行下载
            // 处理中文乱码
            def filename = URLEncoder.encode("用户名单.xls", "UTF-8");
            response.setHeader("Content-disposition", "attachment; filename="+filename)
            response.contentType = "application/x-rarx-rar-compressed"
            System.out.println("========================================");
            System.out.println(path);
            System.out.println("========================================");
            def out = response.outputStream
            InputStream inputStream = new FileInputStream(path+"\\"+uuid+".xls")
            byte[] buffer = new byte[1024]
            int i = -1
            while ((i = inputStream.read(buffer)) != -1) {
                out.write(buffer, 0, i)
            }
            out.flush()
            out.close()
            inputStream.close()
            new File(path+"\\"+uuid+".xls").delete();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }


    }






    def index() {

        if (!params.max) params.max = 10

        def p = Profile.createCriteria()

        PagedResultList pagedResultList

        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "desc")
            eq('status', 1 as byte)
        }

        def profileMap = new HashMap<Long, CommunityTenant>()

        String communityName

        // 查询语句
        String query = params.query

        //今日新增用户数
        Calendar c = Calendar.getInstance();
        c.set(Calendar.HOUR_OF_DAY, 0);
        c.set(Calendar.MINUTE, 0);
        c.set(Calendar.SECOND, 0);
        Date date = c.getTime();

        def tt = Profile.withCriteria {
            ge('dateCreated', date)
        }

        if (query && !(query.equals('null')) && (query.length() == 13)) {
            query = query.replace('-', '')

            //按号码查询
            pagedResultList = p.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                order("id", "desc")
                if (query && !(query.equals('null')) && (query.length() == 13)) {
                    query = query.replace('-', '')
                    eq("mobile", query)
                }
            }

            pagedResultList.iterator().each {
                Profile profile ->
                    def profileInfo = ConsigneeAddr.findByUserId(profile.id)
                    String address = ''
                    if (!profileInfo) {
                        address = '无地址'

                    } else {

                        def community = Community.findById(profileInfo.communityId)

                        checkNotNull(community, "the community should not be null, the profile id is %s", profile.id)

                        communityName = community.name



                        address = profileInfo.receiverAddress

                    }

                    profileMap.put(profile.id, new CommunityTenant(
                            profileId:
                                    profile.id,
                            communityName:
                                    communityName ?: '无购买记录',
                            address:
                                    address,
                            registerTime:
                                    profile.dateCreated.toString().substring(0, 16),
                            mobile:
                                    profile.mobile,
                    ))
            }

        } else if (params.communityId) {

            Long communityId = params.long('communityId')

            LinkedList<ConsigneeAddr> uplist = ConsigneeAddr.findAllByCommunityId(communityId)

            if (uplist) {

                def idlist = uplist*.userId

                pagedResultList = p.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                    'in'("id", idlist)
                    order("id", "desc")

                }
                pagedResultList.iterator().each {
                    Profile profile ->
                        ConsigneeAddr profileInfo = ConsigneeAddr.findByUserId(profile.id)
                        String address = ''
                        if (!profileInfo) {
                            address = '无地址'
                        } else {
                            checkNotNull(profileInfo, "profile should not be null")
                            checkNotNull(profileInfo?.communityId, "the community id should not be null.")

                            if (profileInfo?.communityId == -1) {
                                address = '配送范围外'
                            } else {
                                Community community = checkNotNull(Community.findById(profileInfo.communityId), "the community should not be null, the id is %s", profileInfo.communityId)
                                communityName = community?.name
                                address = profileInfo.receiverAddress
                            }
                        }

                        profileMap.put(profile.id, new CommunityTenant(
                                profileId:
                                        profile.id,
                                communityName:
                                        communityName ?: '无购买记录',
                                address:
                                        address,
                                registerTime:
                                        profile.dateCreated.toString().substring(0, 16),
                                mobile:
                                        profile.mobile,
                        ))
                }
            }

        } else {

            //按号码查询
            pagedResultList = p.list(max: params.max ?: 10, offset: params.offset ?: 0) {
                order("id", "desc")
            }

            pagedResultList.iterator().each {
                Profile profile ->
                    def profileInfo = ConsigneeAddr.findByUserId(profile.id)
                    String address = ''
                    if (!profileInfo) {

                        address = '无地址'

                    } else {

                        if (profileInfo.communityId && profileInfo.communityId > 1999L) {

                            communityName = Community.findById(profileInfo.communityId).name

                        } else if (profileInfo.communityId == -1L) {
                            communityName = '非范围内用户'
                        } else {
                            communityName = '北软、翡翠用户'
                        }

                        address = profileInfo.receiverAddress

                    }

                    profileMap.put(profile.id, new CommunityTenant(
                            profileId:
                                    profile.id,
                            communityName:
                                    communityName ?: '无购买记录',
                            address:
                                    address,
                            registerTime:
                                    profile.dateCreated.toString().substring(0, 16),
                            mobile:
                                    profile.mobile,
                    ))
            }

        }

        //导出当前页用户
        if (params?.exportCurrent) {

            List<CommunityTenant> profiles = new ArrayList<CommunityTenant>(profileMap.values());

//            def headers = ['小区名', '手机号', '注册时间', '收货地址']
//
//            def withProperties = ['communityName', 'mobile', 'registerTime', 'address']
//
//            new WebXlsxExporter().with {
//                setResponseHeaders(response)
//                fillHeader(headers)
//                add(profiles, withProperties)
//                save(response.outputStream)
//            }
            creaUsersExcel(profiles)
        }

        if (params.communityId) {
            communityName = Community.findById(params.long('communityId')).name
        } else {
            communityName = '所有用户'
        }

        return [
                todayTotal   : tt.size(),
                communityName: communityName,
                communityList: communityList,
                communityId  : params.long('communityId'),
                total        : pagedResultList?.totalCount,
                params       : params,
                profileList  : pagedResultList,
                profileMap   : profileMap
        ]
    }
}