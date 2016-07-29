import com.google.common.collect.Sets
import welink.common.Item
import welink.common.SearchItem
import welink.common.Shop
import welink.estate.ObjectTagged
import welink.estate.Tags

import static com.google.common.base.Preconditions.checkNotNull

Item.findAllByShopIdAndApproveStatus(999L, 1 as Byte).each {
    Item source ->
        Shop.findAllByType(1 as Byte).each {
            Shop targetStationShop ->
                Item newItem = Item.findOrCreateByShopIdAndBaseItemId(targetStationShop.id, source.id)?.with {
                    it.categoryId = source?.categoryId
                    it.title = source?.title
                    it.sellerId = source?.sellerId
                    it.sellerType = source?.sellerType
                    it.address = source?.address
                    it.specification = source?.specification
                    it.video = source?.video
                    it.price = source?.price
                    it.features = source?.features
                    it.onlineStartTime = source?.onlineStartTime
                    it.onlineEndTime = source?.onlineEndTime
                    it.type = source?.type
                    it.picUrls = source?.picUrls
                    it.detail = source?.detail
                    it.description = source?.description
                    it.approveStatus = source?.approveStatus
                    //复制的核心，店铺ID，商品编号，店铺等级
                    it.shopId = targetStationShop?.id
                    it.shopType = targetStationShop?.type

                    it.baseItemId = source?.id

                    it.num = source?.num
                    it.price = source?.price

                    save(failOnError: true, flush: true)
                }

                // tag 复制
                ObjectTagged.findAllByArtificialIdAndTypeBetween(source.id, 999, 1999)?.each {
                    ObjectTagged objectTagged ->
                        ObjectTagged.findOrCreateByArtificialIdAndTagId(newItem.id, objectTagged.tagId)?.with {
                            it.artificialId = newItem.id
                            it.type = objectTagged?.type
                            it.kv = objectTagged?.kv
                            it.status = objectTagged?.status
                            it.startTime = objectTagged?.startTime
                            it.endTime = objectTagged?.endTime
                            it.tagId = objectTagged?.tagId
                            save(failOnError: true, flush: true)
                        }
                }
        }
}


Item.findAllByShopType(1 as byte).each {
    Item item ->
        SearchItem.findOrCreateById(item.id)?.with {
            searchItem ->
                searchItem.setId(item.getId());
                searchItem.setCategoryId(item.getCategoryId());
                searchItem.setPrice(item.getPrice());
                searchItem.setPromotionPrice(item.getPrice());
                searchItem.setTitle(item.getTitle());
                searchItem.setOnlineStartTime(item.getOnlineStartTime());
                searchItem.setOnlineEndTime(item.getOnlineEndTime());
                searchItem.setSoldCount(item.getSoldQuantity());
                searchItem.setStatus(item.getApproveStatus());
                searchItem.setShopId(item.getShopId());
                searchItem.setFeatures(null);
                searchItem.setRank(SearchItem.findById(item.baseItemId)?.rank);
                searchItem.setType(Integer.valueOf(item.getType() == null ? 1 : item.getType()));
                searchItem.setTitle(item.getTitle());

                // fffffffffffffff
                BigInteger zero = BigInteger.ZERO;

                Set<Tags> tagsSet = Sets.newHashSet()

                ObjectTagged.findAllByArtificialId(item.id).each {
                    ObjectTagged objectTagged ->
                        tagsSet.add(Tags.findById(objectTagged.tagId))
                }

                tagsSet.each {
                    Tags tags ->
                        BigInteger bit = checkNotNull(tags.getBit(), "the bit of tag with id [%s] should not be null ... ", tags.getId());
                        zero = zero.xor(bit); // 不是OR的原因是我觉得一个tag就应该是一个bit位置
                }

                searchItem.setTagId(zero.longValue());
                searchItem.setLastUpdated(item.getLastUpdated());
                searchItem.setItemLastUpdated(item.getLastUpdated().getTime());
                searchItem.setDateCreated(item.getDateCreated());
                searchItem.setItemDateCreated(item.getDateCreated().getTime());

                save(failOnError: true, flush: true)
        }
}
