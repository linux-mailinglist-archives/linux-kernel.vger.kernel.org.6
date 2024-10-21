Return-Path: <linux-kernel+bounces-373575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4DE9A5903
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBEF1C20F69
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8972D2EB02;
	Mon, 21 Oct 2024 02:47:05 +0000 (UTC)
Received: from out198-24.us.a.mail.aliyun.com (out198-24.us.a.mail.aliyun.com [47.90.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16963D6D;
	Mon, 21 Oct 2024 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478825; cv=none; b=r1npKSPsGqYZADTfqicO7m8GKhEK4JiIhFFLnq1NcMJH8gCrY6oDoceAFsKFs01oGJIksi02NtcvIpt5WkGdKIdNr6g3SqdOaex+L2lqMLMu9FbIzMJZdPV20W6cLu9bmcTXqgf7piTiHNwhcjEEr1U4BGPm/e3TFFIcvoNb2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478825; c=relaxed/simple;
	bh=BzymC0jNPL3WCfIw9jguoaYoTzFQf9oEjObuO2viB7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUvkLGChSdXduGVJVHgVdxmt589l01FJzFJmdXt2D5VUPQI5uJzdBglqCgm5g9uxcH0xMGixI3rp4YxTQLFfQB0bMhvart1myduBKyphJIbd4e9EGKRw+ERzhbLy7ofQNv/g+6MRcDIQgjs1JYAkXoXjWjUq+F9VI99Eux6xqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Znxb1i9_1729478795 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 21 Oct 2024 10:46:41 +0800
From: wangweidong.a@awinic.com
To: robh@kernel.org
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
	shenghao-ding@ti.com,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yijiangtao@awinic.com
Subject: Re: [PATCH V1 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88081"
Date: Mon, 21 Oct 2024 10:46:34 +0800
Message-ID: <20241021024634.7635-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018134721.GA90231-robh@kernel.org>
References: <20241018134721.GA90231-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 18, 2024 at 08:47:21PM -0500, robh@kernel.org wrote:
> On Fri, Oct 18, 2024 at 05:43:18PM +0800, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Add the awinic,aw88081 property to the awinic,aw88395.yaml file.

> That is obvious from reading the diff. Please say something about how 
> this new part compares to the existing parts.

Thank you very much for your review.

I will modify the commit message as shown below
"Add the awinic,aw88081 property to support the aw88081 chip,
which is an I2S/TDM input, high efficiency digital 
Smart K audio amplifie"

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
>>  
>>    reg:
>>      maxItems: 1
>> @@ -57,6 +58,7 @@ allOf:
>>            contains:
>>              enum:
>>                - awinic,aw88261
>> +              - awinic,aw88081
>>      then:
>>        properties:
>>          reset-gpios: false
>> -- 
>> 2.47.0
>>

Best regards,
Weidong Wang


