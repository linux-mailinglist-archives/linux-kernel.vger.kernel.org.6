Return-Path: <linux-kernel+bounces-214369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9282E908358
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AEAB20F37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3077BAE5;
	Fri, 14 Jun 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="LRdDYr9m"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4A13959B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718343090; cv=none; b=oSqPLnYkoAkGM+ka68OKpE2yr3CmFJZ0ypxQRvxMic1haeTaIcGJnl7asoMTQ/ij/ps9zaInqTlfz+kNOrfCuaRYMtpwzmdeDDDpOcOhKBmG2zWm7aH6h3jCZIH5vF3YsSlA3fOfdzHArk5dNL2prERv/dJJuba4D8gOgNXsJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718343090; c=relaxed/simple;
	bh=MmgkyPceFPxKpNbaSqXJcl65JEwmUDlUeY+ic4CYnYI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KBYdAO6B0X8vPrmHNbjMq0i7pTUcbqUbeffDA2g9CWwz+8xhgmD9a1HXEsKSPSRj41d9B84+JYvs1CWlWhrxU3MiKl1SmyVtjFV+kx9RL1o5UdPMQ3RJUAt9LG97dQQ5Hdw7HW/79lbW/kYjt60i7CVzVMU5mcfFwCixCrMfnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=LRdDYr9m; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IPfcbd/aUGEsqafWLH07x0mO4DeKqifKy002DF7qRLA=; b=LRdDYr9myQbRV50HpgD6r3hpA+
	iKyE3YP7oDCWoKDPiIUnQttKxTNUMRZAdBIzfp4hejMqiZikwZJVk9wieV4q2PA2ikWlJu/pw19Cd
	jz24hnRyYkZyxFdo98cwDbelDTwshxHJY6hB3sZMR5EwkoDh/04CUwjK5L4g64PxExOeMOi+OEqS3
	xRACB1o/E+gfrMSEgH1223Sl1gz1Lx0kdLxyAFZobZZNimW7jBK2a+dBtk2+Zs+QhBWS8ose+aY5H
	5+RxtOAODexSn/XsfBlqiDwFpr5HJqRHvTyz5V0SvBevdoDwVUmELrBPoamL0s8GA0K9IAm666KrL
	In7xqp8A==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=54684)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sHzWz-00DqLV-C8
	for linux-kernel@vger.kernel.org;
	Fri, 14 Jun 2024 07:31:21 +0200
Message-ID: <194d0bc7-963f-426f-9755-f8c4413cc8fb@malaika-12.net>
Date: Fri, 14 Jun 2024 07:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: GNU (was The Vast X, Fair Pay Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I´ve said most things from my research now. All on 
https://the-vast-x.net/Ruhban/Ruhban.html

I also noticed GNU is an unofficial correction of God. "Against God". 
However it supports Ya and "Nerd" as derogatory term of Gentile.

I actually did the project Bit in the 90s, and still sometimes ping from 
that, wondering if "Nerd" would be disassociated, keeping a lighthearted 
tone with this project. (NEW: https://music.youtube.com/watch?v=qasmVrjwFfc)

And I do think it has been a success.

The Vast X, will disassociate Nerd label, from computing, masking that 
and also typically Bipolarness, such as in Osama Bin Laden, and Breivik.

And be a good information system, with Fair Pay measures readied.

That I think Everybody wants. So potentially the only OS ultimately.

The Light Be With You,
Ywe Cærlyn
Ruhban.

