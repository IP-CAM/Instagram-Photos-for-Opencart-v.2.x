<section class="instagram-widget instagram-slideshow">
    <?php if($title) { ?>
        <div class="h2 text-center"><?= $title ?></div>
    <?php } ?>
    <?php if($account) { ?>
        <div class="instagram-account">
            <div class="clearfix">
                <a href="<?= $account['link'] ?>" target="_blank" class="account-photo">
                    <img src="<?= $account['image']; ?>" class="img-responsive" alt="<?= $account['alt']; ?>"/>
                </a>
                <div class="account-info">
                    <a href="<?= $account['link'] ?>" target="_blank" class="account-name"><?= $account['fullName'] ?></a>
                    <p><?= $account['biography'] ?></p>
                </div>
                <a href="<?= $account['link'] ?>" target="_blank" class="btn btn-primary pull-right"><?= $text_follow ?></a>
            </div>
            <div class="account-counters">
                <span><b><?= $account['mediaCount'] ?></b>&nbsp;<?= $text_posts ?>&nbsp;</span>
                <span><b><?= $account['followedByCount'] ?></b>&nbsp;<?= $text_followed ?></span>
                <span><b><?= $account['followsCount'] ?></b>&nbsp;<?= $text_follows ?></span>
            </div>
        </div>
    <?php } ?>
    <div id="<?= $plugin_id; ?>" class="swiper-container">
        <div class="swiper-wrapper">
            <?php foreach ($photos as $photo) { ?>
                <div class="swiper-slide">
                    <a class="instagram-item" href="<?= $photo['link']; ?>" target="_blank">
                        <img src="<?= $photo['image']; ?>" class="img-responsive" alt="<?= $photo['alt']; ?>"/>
                        <?php if($photo['type'] == 'video') { ?>
                            <span class="video">
                                <i class="fa fa-play"></i>
                            </span>
                        <?php } ?>
                        <div class="item-hover">
                            <div class="item-inner">
                                <span class="likes">
                                    <i class="fa fa-heart"></i>&nbsp;<?= $photo['likesCount'] ?>
                                </span>
                                <span class="comments">
                                    <i class="fa fa-comment"></i>&nbsp;<?= $photo['commentsCount'] ?>
                                </span>
                            </div>
                        </div>
                    </a>
                </div>
            <?php } ?>
        </div>
        <?php if(!empty($pluginOptions['navigation'])) { ?>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
        <?php } ?>
        <?php if(!empty($pluginOptions['pagination'])) { ?>
            <div class="swiper-pagination"></div>
        <?php } ?>
    </div>
</section>

<script type="text/javascript"><!--
    var insta<?= $module; ?> = new Swiper('#<?= $plugin_id ?>',  <?= json_encode($pluginOptions) ?>);
--></script>