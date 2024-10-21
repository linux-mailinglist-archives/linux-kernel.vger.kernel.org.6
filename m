Return-Path: <linux-kernel+bounces-373576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57BB9A5905
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C967280F38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C631A60;
	Mon, 21 Oct 2024 02:48:46 +0000 (UTC)
Received: from out198-28.us.a.mail.aliyun.com (out198-28.us.a.mail.aliyun.com [47.90.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185183D6D;
	Mon, 21 Oct 2024 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478926; cv=none; b=naE5FMtmMmSqzn+Md/aTORWUE29czRu28ae0oKkXnPSY1TZ8D+mCkKXx7IGs97IiLMa7b3MOvBEOclMKAM93djzm+5p7cDxGduWXIX4OZxQYGSwmLSDucX5t7OtPDe9jfOfyHi66PG5cRDGya2VykHlVckBpZF29TrUVYOXEAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478926; c=relaxed/simple;
	bh=achw4d6CHKRfNvKnSB/jTkXDcZh8x380MG5DY9Q+B0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGy7OTe3lEhmI9twXEa8AGPgs9BaWMZBA2wQUkN3D2EBvGHSNFB36iSaJOdMvIlDtjc0mUDgWjSUT45r4UGtGQn485BBUH6Ozh1Ri1cae0kxCCrQYZma+h3KEgUq1/SgzrT9UWdZkzgb8XJxVvOIr9BWgumUbRFNNfz79rlXDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.ZnyAIBS_1729478894 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 10:48:20 +0800
From: wangweidong.a@awinic.com
To: yesanishhere@gmail.com
Cc: arnd@arndb.de,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	herve.codina@bootlin.com,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	luca.ceresoli@bootlin.com,
	masahiroy@kernel.org,
	neil.armstrong@linaro.org,
	perex@perex.cz,
	pierre-louis.bossart@linux.dev,
	quic_pkumpatl@quicinc.com,
	rf@opensource.cirrus.com,
	robh@kernel.org,
	shenghao-ding@ti.com,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yijiangtao@awinic.com
Subject: Re: [PATCH V1 2/2] ASoC: codecs: Add aw88081 amplifier driver
Date: Mon, 21 Oct 2024 10:48:14 +0800
Message-ID: <20241021024814.7712-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CABCoZhAcsUQbaSvawUa3Px0BK4eUVXV0Kfp4Y8AtgPb2PPMfmg@mail.gmail.com>
References: <CABCoZhAcsUQbaSvawUa3Px0BK4eUVXV0Kfp4Y8AtgPb2PPMfmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 19, 2024 at 09:18:59 -0700, yesanishhere@gmail.com wrote:
> On Fri, Oct 18, 2024 at 2:44 AM <wangweidong.a@awinic.com> wrote:
>>
>> From: Weidong Wang <wangweidong.a@awinic.com>
>>
>> The driver is for amplifiers aw88081 of Awinic Technology Corporation.
>> The awinic AW88081 is an I2S/TDM input, high efficiency digital
>> Smart K audio amplifier
>>
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>

...

>> +#define AW88081_INIT_PROFILE           (0)
>> +
>> +#define AW88081_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
>> +{ \
>> +       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
>> +       .name = xname, \
>> +       .info = profile_info, \
>> +       .get = profile_get, \
>> +       .put = profile_set, \
>> +}
>> +
>> +enum {
>> +       AW88081_SYNC_START = 0,
>> +       AW88081_ASYNC_START,
>> +};
>> +
>> +enum aw88081_id {
>> +       AW88081_CHIP_ID = 0x2116,
>> +};
>> +
>> +enum {
>> +       AW88081_500_US = 500,
>> +       AW88081_1000_US = 1000,
>> +       AW88081_2000_US = 2000,
>> +       AW88081_5000_US = 5000,
>> +};
>> +
>> +enum {
>> +       AW88081_DEV_PW_OFF = 0,
>> +       AW88081_DEV_PW_ON,
>> +};
>> +
>> +enum {
>> +       AW88081_DEV_FW_FAILED = 0,
>> +       AW88081_DEV_FW_OK,
>> +};
>> +
>> +struct aw88081 {
>> +       struct aw_device *aw_pa;
>> +       struct mutex lock;
>> +       struct delayed_work start_work;
>> +       struct regmap *regmap;
>> +       struct aw_container *aw_cfg;
>> +
>> +       bool phase_sync;
>> +};

> Are you sharing this struct declaration with any other file?
> If not, move it to .c file. I think it is better to keep register
> definitions in .h and rest move it to .c file if you are not sharing
> with anyone else.

Thank you very much for your review.
I will move this struct to the .c file in patch V2.

>> +
>> +#endif
>> --
>> 2.47.0
>>
>>

Best regards,
Weidong Wang


