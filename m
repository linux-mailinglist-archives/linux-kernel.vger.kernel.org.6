Return-Path: <linux-kernel+bounces-169114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629A8BC348
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C71F219B5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B16DCE8;
	Sun,  5 May 2024 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="p0f3mQco"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7EF27462
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714938138; cv=none; b=innmcLVOl2i67uJkeVxvOX11fdto80BNcJBlnyM6R1NSQgmiOo3T/KfxQCnLV0VLAVReE6I2PZYVtkdBJODq4K+cPq8eB3Nng3DulqmiIkQ71pkT9SDoNekmvDTXz4HWVK3LY0MrcePy6J3atK8few60WZspbcahVQA2IClgslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714938138; c=relaxed/simple;
	bh=B60tiOZzqoQTSu/cNH9qcRRV0feyN5DtonS1lm6mRvg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oZNxk+/cPr6fZJf0b16HwcHS04+mSsWqU5nberxLepQLwX7HiqZZkdohfWWSjGGaxZkKuv85ttSf1l7IohdSSggKE4l7A6ZvTlLlKsJ8s3hBuwrjPuoPbSTDoJsaQhNk7die8+b5NAwQKWvLTht4x4XvyizEgb+NKJL8xQ8E88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=p0f3mQco; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AlIzxxDsty2bu3x5tAVljQA7dN9TE+4TZO8XfFxCw+k=; b=p0f3mQco+hvyzm8QByCtisqCxM
	agOgNTzUKUdcc+s7SYJTjL2fcwxnarwe9DORWKHoUXWGLa4ep4Izju5C6PiZ7/jmwiH5htL00r9/I
	uq+oT9rZ2UjIIOYd96nTBRZ/PJdO6xjgx0p1m1nqsEW4Hyii/OWPounZFUAT1t0VVOKylYnmuCYjW
	s22IS52LeQ8Psfoedp5qnm5pwXC8sBp+ncDBQLGtmyW75n63aZc/geM17w8HkkG+esb2Apd1PXknz
	DYz4addBl7yFPooDtns4cPdX0V6cfPGLRmDDVWD7nTcnvTvO/HtDLpeCVOi0WSttAsiwXAnZKT0yv
	kRsW3DuA==;
Received: from [2a02:fe1:7001:f100:29e9:e11:fac9:2a2] (port=53828)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s3hkP-00DmIA-3L
	for linux-kernel@vger.kernel.org;
	Sun, 05 May 2024 21:42:09 +0200
Message-ID: <ea8baee7-0bf6-48f5-9ba1-50b7206bc956@bit-x.org>
Date: Sun, 5 May 2024 21:42:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Fair Pay Regions (The Main Political Cause Of Open Source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, I updated my little chart on https://bit-x.org/BIT/BIT.html

Stressing Fair Pay Regions.

Many people claim the political systems of today are failed. Islamic 
States, Republics, Democracies, Theocracies. Nothing seems to work.

Typically the Republicans of America attack the Democrats reducing them 
to feeble thumbsuckers. This solves nothing.

Indeed Fair Pay Regions through a computer system is the best thing to do.

For instance, for Norway, Sweden and Demark: Samilands. (Sometimes 
called Scandinavia but this is a mixup with Scotland and should not be 
used.)

The Light Be With You,
Ywe.



