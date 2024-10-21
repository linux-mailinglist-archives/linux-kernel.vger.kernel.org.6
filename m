Return-Path: <linux-kernel+bounces-373574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F779A5900
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADA71C21120
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994543AD9;
	Mon, 21 Oct 2024 02:43:58 +0000 (UTC)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8083FB8B;
	Mon, 21 Oct 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478638; cv=none; b=LqySdc4H/eNYtPVxTMp07YX1zuSX+oyn1NcSf+slTpaBjuU3ihojCi1REMe6hdBcW9VwscPaVPah48T1RgwBICep546O9gxG33mR7QkUizKc4BcDP6eRiv32AKHHm/Y0u/CuS/9qERZHDa5tPZnKpr9pf2MlmOtjJYIYVejHU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478638; c=relaxed/simple;
	bh=tsX7pw2zeVtotLD4KvrH73gVTMOPVdqxTsawDmCzK84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cna+NK7c6snnMMn8sUNh0+ind+illzzEh31x73OYHpktu7SCuTxa3TJ8LhMA9l+01duvy5d/diKZ9Br0lD9HC/ZUjHeTVNIlQHcABIz0P5vvdRABNinVXID/rRhTRSNtBxHRSCK731DLiYhz388SXfr2t1FBFrq6ISvoGuRkH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Zny.adN_1729478617 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 10:43:43 +0800
From: wangweidong.a@awinic.com
To: krzk@kernel.org
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
Subject: Re: [PATCH V1 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88081"
Date: Mon, 21 Oct 2024 10:43:36 +0800
Message-ID: <20241021024337.7418-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <0311a205-f9fd-47fe-85cf-1e412801cd18@kernel.org>
References: <0311a205-f9fd-47fe-85cf-1e412801cd18@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 18, 2024 at 12:08:08PM +0200, krzysztof.kozlowski@linaro.org wrote:
> On 18/10/2024 11:43, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add the awinic,aw88081 property to the awinic,aw88395.yaml file.
>> 
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
>> ---
>>  Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
>> index ac5f2e0f42cb..b39c76b685f4 100644
>> --- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
>> +++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
>> @@ -20,6 +20,7 @@ properties:
>>        - awinic,aw88395
>>        - awinic,aw88261
>>        - awinic,aw88399
>> +      - awinic,aw88081

> I am sorry, but what type of sorting are you keeping here? It looks
> entirely random.

Thank you very much for your review.

I will change it to
	- awinic,aw88081
	- awinic,aw88261
        - awinic,aw88395
        - awinic,aw88399
in PATCH V2

Best regards,
Weidong Wang

