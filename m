Return-Path: <linux-kernel+bounces-422349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBF9D987E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B862841F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15301D47C7;
	Tue, 26 Nov 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="EgIvM93B"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F4522F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627547; cv=pass; b=Uzyv2wYfmxnK743tJ2Lxs2NdiE9FKWH6ItkC4auPOxV6tsLRpTEmodBdHKaYN/5wnMXCma3W7iQ/CW4iMOw7Jhm1CGHmMDtrO1IM235gBhxD0cQPizys3mpywieOkTB9LimlflRt9kt5IexUiJ3NXrYOEXAzdAiAUX3xiBpk9Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627547; c=relaxed/simple;
	bh=l4N6qZBbRn8EAvIL6JyA3SOFSqp1Yvwj3SmVUH9iUas=;
	h=Message-ID:Date:MIME-Version:Cc:From:To:Subject:Content-Type; b=I/yCE8czZpJzCSFk99d65DH9U8Ld89RQkMgxA0MYunynFbD4yR6VqmBJiwISL18zQW3/cXVP73qGBWznxtgLuNsEQa8uNcliLqd6I8yB0XDnxQ8Q/yoMTnNr8cu+7sIq2BoXw6N27aIz2z6zdweXirrVVlryku0g+gtsbHlP08A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=EgIvM93B; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732627543; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lASto6zWShqfXPlBO2VCdPnMH35iSQTUMOKaNqmOnOvQmGEj5Un3LeB2F9aOBfz145RR9sD47B+RvDckuFdiHolehAr+vXj1bq4YGzThh+oIfQb8tiLUSfAcGxVMr1ySn6Nrl/bZtH8JgF33ciz7fp6VgNVNm+ICt9uxAigCvwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732627543; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fCKHoPx+L0qkIMAC8WPcrHW9BZSoJ0Y2i0s5upJx++I=; 
	b=SthTrKHd6DCQ5Dxg/+6ciHjUKi4keIl99QijDna9qCSJ/Yyvgx4bYLAArmTVB3YTsvsYrJGPpQ8Yo+USVnm5/uxRg99nYHCzV4bUNIJqwO7UblAVo1qU7CreivUgAGzlX3TJSEq9Bhd5PI9v2EwtB7UbWdJg1b1VmNt++LMunQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732627543;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:From:From:To:To:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fCKHoPx+L0qkIMAC8WPcrHW9BZSoJ0Y2i0s5upJx++I=;
	b=EgIvM93BL1FImZF3PwgCRuyk8KkmUqOFBWACxPL3re6OVwGUond6GiHtwXLiHaCu
	r56FsdrSvSDMYIIgRK42qBhBkKRYFeohfiPK/7Dj01Q+74qu2TJzEsdebY7cguvhSLg
	sexNK/Up8zh3/J/4h6I9xu0lCkie/BtxwUS0Ltyg=
Received: by mx.zohomail.com with SMTPS id 1732627541192283.3545783377284;
	Tue, 26 Nov 2024 05:25:41 -0800 (PST)
Message-ID: <91c041ac-5491-4c97-9afc-9eb11c8e686c@collabora.com>
Date: Tue, 26 Nov 2024 18:25:44 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Bug Report] Depmod is failing on allmodconfig for arm64 and x86_64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

The depmod is failing on 9f16d5e6f2206 (mainline) arm64 and x86_64 because of:
```
depmod: ERROR: Cycle detected: libphy

depmod: ERROR: Cycle detected: lan969x_switch -> sparx5_switch -> lan969x_switch
depmod: ERROR: Cycle detected: ptp
depmod: ERROR: Cycle detected: stp
depmod: ERROR: Cycle detected: ipv6
depmod: ERROR: Cycle detected: bridge
depmod: ERROR: Found 2 modules in dependency cycles!
make[2]: *** [scripts/Makefile.modinst:132: depmod] Error 1
make[1]: *** [/tmp/kci/linux/Makefile:1844: modules_install] Error 2
make: *** [Makefile:224: __sub-make] Error 2
```

This issue wasn't present until c66fbc6c3df9. 

[1] https://kcidb.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=arm64&var-build_config_name=defconfig+allmodconfig&var-id=maestro:67427d2a923416c0c993033a
[2] https://kcidb.kernelci.org/d/build/build?orgId=1&var-datasource=default&var-build_architecture=x86_64&var-build_config_name=x86_64_defconfig%20allmodconfig&var-id=maestro:67427d2c923416c0c9930358&from=now-100y&to=now&timezone=browser&var-origin=$__all&var-test_path=&var-issue_presence=yes

-- 
BR,
Muhammad Usama Anjum

