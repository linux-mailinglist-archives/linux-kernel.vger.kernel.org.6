Return-Path: <linux-kernel+bounces-360973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173E99A1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83955B24EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA18D20FA9A;
	Fri, 11 Oct 2024 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="oALMfKyY"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1A20B1E9;
	Fri, 11 Oct 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643635; cv=none; b=LcbTL50VUGl/5AvFnyKRC5XLxV6VjdgeEOY+aXBrjcI6ughL12ecKA4pXT1ak1DZNLa+riOUASd5985n/ty//150BFIVnbCDz7Gs3q/MWf0SrREDOEO0V4r0fUu+u36DilmlfUrSS52Y5CLEsFIotXlTitzedex3nIAhxHHIGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643635; c=relaxed/simple;
	bh=e4ng021xGTHS1X1b3UQjGH4+V7Gq8ouwcuISOdxjeDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwqLqFprCUvm9NnAuuQFp1tXOyGoRzSsz9exIEiTYqeP5R96QOKN17oGbX43BLhAiiHFnD22pbSKoM/DNsgDqEwMXy47DLtfMRnS/IeHZmVBMmhInNoNyKX0KdAP93J36EJw8wMXKD2MAMXKjL7ZIktbxaXEXITlm4WPA4UlhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=oALMfKyY; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728643621; x=1729248421; i=wahrenst@gmx.net;
	bh=e4ng021xGTHS1X1b3UQjGH4+V7Gq8ouwcuISOdxjeDU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oALMfKyYHmOpqrD/UwIW+7/JP9wlq78+ZvTpp1jbnhVu/ioD0rD8jl89enIoU4Mf
	 IqsuJlwfINvq9zAaO95h3NVO18p/Cofw//gQzOgFH5K0EbVZQr10eq/eXye9o7/IC
	 kI3ALa67r9ONMW47D5L378yPDs5dy3/dBmzcHTqA1xJwmEIZVR9cOQYNVYZpb5RMh
	 AfCnpPuWcStQd30wwJP7J7K96HmJz4WemV6SU0yJJw0hFMaSUd5/fmnvgxnOXV5FL
	 Qup6t+4ZzUtcgYvYa43Q2euXY3W16sJ2/9JFpCh3sDWr5atvnoeOG/+INwtA/io8R
	 8BVC6n6iVGkwPXTsJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1tZNT62mSD-00eNK9; Fri, 11
 Oct 2024 12:47:01 +0200
Message-ID: <84f5a045-de3b-48f6-8c20-f04c7f818844@gmx.net>
Date: Fri, 11 Oct 2024 12:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] staging: vchiq_core: Do not log debug in a separate
 scope
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
 <20241011072210.494672-4-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241011072210.494672-4-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pwx38uK1X7HbvZkvkdF4TtdxfaCwr6hOdlfpMKsNG+2KaOdSMIK
 rc5u1oRccxWAdVLvNiAY+AWYlpQcENn/eMdHWcgeX+hsCSHhrAxgkcjsulvPkCSIQJ6FS5m
 ZToIe/jGz57MF4fs6BdviB0rpG9ygqqtaXzsai0RKy4wTWljB2CltjnQvOlQL7UCrxqJ5sP
 5zNIM8/M3XR3hrpH0wO/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2EeTUd2qz6o=;e4NQsPGuDRQBvDzIgvJmQq9Yyhp
 AaCTNqtE/kfMTBAxCRShjJY/w0G2vgw7Zdv/KypE1BCqeHKgGrsb2cthzjvqqFOMPY71GeMPr
 CsQWqP5o/aVg+fm1zDOqZXOynGha5IBCsXeF9kR7V7LReqyCR+rdpIbcXoX29p22PRJVIGD1p
 z3kN726Ehy0msydS2RoxdQNyofT9f0Gz+mo+unSSzXLKB3Mm5+ESn3q192Adv43iUeFGGfSE2
 cLiXA/hHHCQfcuO2k8cRIesfohJZ81gVLQ7j/0TzBLppJghkmsmnPOSrVzIpeaPBcXtIcFVoD
 t3/XP+pRe/G6F+lxFSDBD0vtSz3WBBgQtdz5Cx2Uxn5w08ga0KEkemZrIK8t9Jq64oIZ4/qnx
 KfBL5D0F51SnqEu304l82DpqPEks0dOAdREaFa6HNMr4x7P6j4O98/uX3itmb4sYaPDpfnucn
 qu4g/v5HWlUQMB0SMXAD0/7HYHHTuvI2pd/UWjP3OlAqIvh5s2nNmFyUPo9CBEP9ccGLZdA02
 yd6DxfxK4yaGMwz646SUsiYWpbtKyRWxwIRIPDJ5D/Mt2b0OohZYvTVpqioU5/VVFQ3No++qQ
 JvDDjUU0P1aPRgfNvj+zaeg7LoymRqsbNawN0HkSJTwuxQX/NF7BBJsE9ucwlDyItbG2AZowr
 imVMM68D4JfJ8lgdfhw4c0t+xPhUTsS3tBdF2jh1c2LTQdDabAEbfaCCN7QRi9ZknWVHyhg/N
 XiKx8sENiE91ipSpxl+kXpvAdSttL51FC/HwUj23E3BLp13HdPQXWPcNCfr+5cfSnqsaihMgK
 WMehLLY+A/uC3agmGU9MFrfQ==

Am 11.10.24 um 09:22 schrieb Umang Jain:
> Do not log a dev_dbg() with a separate scope. Drop the {..}
> scope and align the dev_dbg() to make it more readable.
>
> No functional changes intended in this patch.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

