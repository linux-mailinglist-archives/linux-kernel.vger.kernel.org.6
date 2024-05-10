Return-Path: <linux-kernel+bounces-175333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 865668C1E22
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC9B1F227E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868F56B9C;
	Fri, 10 May 2024 06:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="C3DM713X"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1161E876
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322818; cv=none; b=VxMSBKAJFiziIQeMcuKH6XHag0emLgCQAaqij2ZUMTxq+TVpo6BLsH66zeJOAdzMdd2Z+FOXyk8y2Fb+BhErctGIOPT+j7BdOEfGwzVGlvbEcinNpd4CpTsbA3AVwLT5fhwEVDemSJsBEBdAUrDrb0XpdRDFatsE0Agm2lgO9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322818; c=relaxed/simple;
	bh=cs2uCEPZ2queaI3Y08dzcNLbo5ENYC8TyXw0m4o+TAI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CWNexNHt9yioMkroTiuNnjckgjtC2Cv4jHgDf7tNlyInrelhsPDfG8QGhloaruU5dYpZijd9Ptkt8YSpR+Ssgh1lHX9yc4Bd++T1fQsyVCC/kIEDg/Cb+r7Z8TmpsY2/py6m4HtSg78OjFP35rMYLS1yV1tyB7fBkDPf3RRg95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=C3DM713X; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qgr9IpMRctnIFqJm2dbO75HLt287kgs26KK3eVoOYvA=; b=C3DM713X924J2SQE4+xs5hKXDl
	XwGG878zxirrjBDa7k08+NP/EBp2kWgGJb9LbBEANWN/NP+fg2Y9G8WbdGLP0DI19yX+dmj8xYisr
	01FPHR08asTyB4eQwzwaSugvrwEThWQCNXecpyCvpNvjQYMz0M1Q+QrSMINdH0hYPopTobeyXth6Z
	6Myf4X83mFZpmwHpXK0q/xL3wi1oHm0xshw+px780SGRHjv8rdidycgh3yshFJbba6V7T5SF2OQfW
	3OlQr3mfw12vlVq+salfS6/21+ninIjTkPxqE/DoROd+0HDboHCehAby4ZRIDu96PjaM2zqMWSvpQ
	PrispqMw==;
Received: from [2a02:fe1:7001:f100:c9a6:32:edff:c6ac] (port=50555)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s5Joz-008jVq-H4
	for linux-kernel@vger.kernel.org;
	Fri, 10 May 2024 08:33:33 +0200
Message-ID: <7975bed2-2969-4964-bbeb-4f763dcd5f13@bit-x.org>
Date: Fri, 10 May 2024 08:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Bit X, IT Icons, design style (was Fair Pay, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, using IT for iconstyle seems good also. Updated my summary graphics 
on https://bit-x.org/BIT/BIT.html

The Light Be With You,
Ywe.

