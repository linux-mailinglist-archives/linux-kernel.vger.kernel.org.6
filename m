Return-Path: <linux-kernel+bounces-373176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7949A535C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303A51F2135C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AAD155398;
	Sun, 20 Oct 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="Jlx3eQxC"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391B2942A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729417021; cv=none; b=kFDhB/veedTddbCPhDMaKGjHe7cq/nqTzCjToEYeVp/t7khi+uwbxCdlEXfYWjfLflFSwDxjM4ig1DWQhkCzvM9D9VRXUsNAQ8fq7o+zmCARwdPRYcZwnoYEgHX7iCc6XofJpDBN1NmEGya3bcgkzsJFmeW7KuGGev9ZLUzkjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729417021; c=relaxed/simple;
	bh=EyvjrBQH9gaPHe01nY8i6dEiX9RqExmByYmwgDK7WXo=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=jDg8zaaKQi37TewCArb0C1UDdIdf+48vJ0903TZhjB0fprhHuCxUqWO5C8lW1LNTycOGurlq9aKiKb0BN5ihd6IdBMFdqKnoff797CgAio1rtwPiylbsRO5EkROo4DQtSn0cWfagm9y52KhvJ3NK2GTPhc4fzyLcHsEODsr9wfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=Jlx3eQxC; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id 2CBitriw6vH7l2SMmtOAOa; Sun, 20 Oct 2024 09:36:52 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id 2SMjt0xUjWvXp2SMktwtNI; Sun, 20 Oct 2024 09:36:51 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=6714cf33
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=geAcWm3dhgwnT0Pjoka1yw==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=-pn6D5nKLtMA:10 a=jMfKuDRYAAAA:8
 a=MRSqTl_Y5bnSglAJojgA:9 a=QEXdDO2ut3YA:10 a=-3YgmSAAc2L1nfTqJm0e:22
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:Cc:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KITBDFaLu+p+liV4EGL9fJsqmIbuK3wBQMfUQMiuO9c=; b=Jlx3eQxCVCA5I43XzaOwUsPCKJ
	JO7aFh4FC+MY2cjpSgdiqaBOJLSgC4NaEAsSzUdbty9BCUCh3c3ZUylK6TzywMoSth74wIJdcLyN8
	kLSlMhaL5r4uPQA3ajWhY884TvX3bf+ufICrYuVQ+fFpkr9+fH6fnUrYEoUwcrxBx0eVnCnbze9hI
	M72sU5El1BhZbcj9rdxyRphly3GcYKkCNjQvxwM5HF2+4jjJHV8jWPHR5hsziXBeOniWahkmL+m7c
	tDLHWn0YIKXpSn4I9Qcn+8R6BH7BsV0dahpJQ2dOolZjCb8/S2Hbg4Rs5Vqs8kpgsQTEKf5SxL2YM
	yGfQCNvQ==;
Received: from [49.206.112.194] (port=10042 helo=[192.168.0.206])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1t2SMi-001xFP-1D;
	Sun, 20 Oct 2024 15:06:48 +0530
Message-ID: <2dc2c052-8fde-4656-8dbf-a6980cd968ae@linumiz.com>
Date: Sun, 20 Oct 2024 15:06:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org
From: Parthiban <parthiban@linumiz.com>
Subject: A133 support
Organization: Linumiz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 49.206.112.194
X-Source-L: No
X-Exim-ID: 1t2SMi-001xFP-1D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.206]) [49.206.112.194]:10042
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKTSFl8Ghf3/76hOb4g512rigWg7Z7MaQfES/3cM0Yx2LUhO75zMqTmOm2XSZWcEG/n3Wr0CVbkoSYvKKBwErJqG1crY8ocvPhYxPwnhSyuQwtHGqoip
 1C+OaIND3utmTXD5208ZPgcsF3BB6UCeTo+hh4UgS18zqW9urZsv4W3s7HhzCCvdKWaI2bHnqFTQAcC7Ei2ubJFEZyQghv2xXtM=

Hi All,

Am currently adding support for Allwinner A133 SoC based on A100. Based on the [1],
A100 and A133 uses same IP across. But there is no public available datasheet or
user manual for A100.

Should A100 kept as base and A133 dtsi needs to added on top or A133 can be duplicated
into a new devicetree?

[1]: https://linux-sunxi.org/Linux_mainlining_effort#Status_Matrix

-- 
Thanks,
Parthiban N


