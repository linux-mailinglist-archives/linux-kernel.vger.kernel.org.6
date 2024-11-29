Return-Path: <linux-kernel+bounces-425216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD4B9DBEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5024BB219FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C721547E9;
	Fri, 29 Nov 2024 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="f3ErCGcG"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4D45C14
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732853662; cv=none; b=MlGsQEabhgBIdd3DxGrPjAXHmn4nR4VbmvSM9Xh/tXrVt6kTeDTN6eZ0kE9rfUqX5e/tkMXt6bRRSzRygevMxSkluoBIe1GpOPFnmZzPvz2SQgBUNajZN4SKtb3DLBONJpMRss4J3zjHVlaGyaP1Zq0Ugi24uGhICRP0VboYfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732853662; c=relaxed/simple;
	bh=7Q5uoccyOFHjDwzni9s1pvqhXs3JznPJtn8MoISASRU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EGsZfP+oDH2/Vu0X3K+Jz1S8o8xpQ3fSvFAPIooLYdqofYKZXNDrD6MuF3IdFDn2sqD+P+HAgWvq7a3XPjtw9bx/Eb2W89nBfryDm8EOtijaOYd3VRd4wfZnpqtkbfJEmvpUwfHtufI58kues02Jo9w3EvJCICn8WFxW+FtWxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=f3ErCGcG; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id GCgktV7RNg2lzGsOQtBsjG; Fri, 29 Nov 2024 04:14:11 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id GsONtNZcHNWjnGsOOtKzmB; Fri, 29 Nov 2024 04:14:09 +0000
X-Authority-Analysis: v=2.4 cv=dOagmvZb c=1 sm=1 tr=0 ts=67493f91
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10
 a=a9eFdPKkdgbxhWDV1dEA:9 a=QEXdDO2ut3YA:10 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Q5uoccyOFHjDwzni9s1pvqhXs3JznPJtn8MoISASRU=; b=f3ErCGcGBfb1iyOQo+fcBv1t7e
	6gIj1pftIjig6fL7tveuQjbhA03eV/QcD+R5rWTQe8Kn9b8yRm0dBILPJMeIAtcfUfaokPCf8bEQi
	VnM7TkIpwvFLSw3xj9BQhyi6Gh69ZUuRR9boclxSbWyPKx5IifgE+g3dfVaP856rdqNtazS6Wz5YF
	JpmSzV9RSZH3SLtqW7qKwH+Fxg2hykOB0b/Lml5yUanGNm9nRgIDBLwLO7zu4QpPtTIwTZsg6evED
	zsR5Vc7+gG5Tkk1K8TlzyM6VmhDxfJBgYFDuuJLK0ncSsuEditRyf0gLS4IJzvUb11IMcRspqyPew
	2Zwa/xSA==;
Received: from [122.165.245.213] (port=53154 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tGsOG-002aNG-2V;
	Fri, 29 Nov 2024 09:44:00 +0530
Message-ID: <fa7dbac4-592e-44f9-b468-834779fdbbc2@linumiz.com>
Date: Fri, 29 Nov 2024 09:43:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Andre Przywara <andre.przywara@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Workaround TCON TOP conflict between DE0 and
 DE1
To: John Watts <contact@jookia.org>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
 <20241108115357.691b77b0@donnerap.manchester.arm.com>
 <Zy4SKCBwce3q0yj5@titan> <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
 <Zy4c9BFcrz2JVU6k@titan> <ZzNCsFiAiACFrQhE@titan>
 <f0d5b314-cfcc-4856-8d6e-09e437c075ec@linumiz.com> <ZzPluoI7xSTwhNcm@titan>
 <2ef6afa0-2756-493b-83a4-62e73a8e2af9@linumiz.com> <ZzRgP7-hHWE8JH8K@titan>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <ZzRgP7-hHWE8JH8K@titan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tGsOG-002aNG-2V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:53154
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLqsGSjw5egsgoGk+qB/UySeOkcTDBwWzCowcRvo79psmpCdHSLHXXDWxKlrgj+SJGgRBHzWhB0Ml/YQyRIkHrcg6lMepMoTRzI78wPxtrKvuTSSIFO9
 kpeSuep7QfX/bNYU8u2BeWz3/n/nl/N72H51OX48OEhsrUHmzDdFIRdEcKtToA9WoyoagydzBg4oAbNdFPVylSgcmvrSEpd5L6c=

On 11/13/24 1:45 PM, John Watts wrote:
> It really seems like the code means mixers here.
True, I was wrong about my statement. But with A133, the case of independent DE
is unique, which I couldn't test yet.

> If my thoughts are correct, this would break use of mixer0 and mixer1 at the
> same time.
Agreed. But back to the original discussion about setting 0x20 to the port
register, it work fine in my end without that changes for A133 display pipeline
with LVDS. Not sure if the reason is independent DE.

Thanks,
Parthiban

