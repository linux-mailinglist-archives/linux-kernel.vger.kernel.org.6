Return-Path: <linux-kernel+bounces-316342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965496CE31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A633EB210DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2DA1552E0;
	Thu,  5 Sep 2024 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b="ej0y1CJN"
Received: from mod.modforum.org (mod.modforum.org [192.254.136.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40709143759
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.136.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725511510; cv=none; b=enXDoRBtHxQ/3R52MDgCTXXuUwdsNLx+aA93L+HLmUG2VmWTvL6TSd8f3/Exu+KKnTG9n/pz2OYf17+UiZasJiMn46pQU+tkp5TOpduH2u2Gle+A2Xzi6Sfl8JhnX+y49o3/2aoogQJ0crOldxVxLCrtfyoeu0bM5pP0xFif2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725511510; c=relaxed/simple;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmc2Vl4gYOZykKxUYH/lHBqTJu7qTlLvJb5xIeIW6sU5rqTbOPEN+MbaHBfcpVQCdcKXP8nyLyaHdMJe7LVsGcKy1uAsszA6IN1E8cj63GMa1MGesk8CYxJZ1rNQ8mOVVvT4OWh07KxkedMayEHTokpVn47WlnrzIkmq/vppMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com; spf=pass smtp.mailfrom=basantfashion.com; dkim=pass (2048-bit key) header.d=basantfashion.com header.i=@basantfashion.com header.b=ej0y1CJN; arc=none smtp.client-ip=192.254.136.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=basantfashion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=basantfashion.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=basantfashion.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G4BItOc8k/hB4suOfWWwTOg/U0FTlHwyCNnKCLPge2w=; b=ej0y1CJNJlaUMuzJpZPaKqgORQ
	0Jx1eWEvzKTsoopbYTtrvLbN9EVTkSHtQRQT3Uw1DAXea7k2QiroLiegEFrZAWUyDUCqxCR0MTOy2
	NlmIssqQH7JjqgRyIbsKC6KyGqKMJTXWdpIBvVB/PQHenamZeoyEoOVSeiZ2SdN3kg+vhKWsnQSwJ
	1FSix+XhecqTPMCJj5t9BFKUyVRYYYWxgfeSNYoLHcXuoJfLRH5MuXjq9EkAbLxsAXDQKad1lCnV1
	CxLQu6rc2J4TDJZNUuWfJ/vgZfajw2vNFubcqZiX3ECfM8ebRMhZYbkVc9NWBW/0lkLIkE31kBBge
	Gy8vFOjA==;
Received: from [162.244.210.121] (port=60821)
	by mod.modforum.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <kuljeet@basantfashion.com>)
	id 1sm4Lq-0006kT-Ku
	for linux-kernel@vger.kernel.org; Wed, 04 Sep 2024 23:44:10 -0500
Reply-To: procurement@mercuira.com
From: MERCURIA  <kuljeet@basantfashion.com>
To: linux-kernel@vger.kernel.org
Subject: Request for Quote and Meeting Availability
Date: 4 Sep 2024 21:45:06 -0700
Message-ID: <20240904214506.FFA5AE11D9870CB0@basantfashion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mod.modforum.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - basantfashion.com
X-Get-Message-Sender-Via: mod.modforum.org: authenticated_id: kuljeet@basantfashion.com
X-Authenticated-Sender: mod.modforum.org: kuljeet@basantfashion.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Greetings,

I hope you are doing great.

We have reviewed your products on your website, and several items=20
have caught our interest. We would like to request a quote the=20
following

Can you ship to the United States?

What are your best prices?

What support do you provide?

We are also interested in your services for this project.

Could you let us know your availability for a virtual meeting on=20
Zoom to discuss this project further?

Please advise us on these matters so that we can prepare a=20
meeting notice for our company executives to effectively engage=20
with you.

Thank you for your attention to this inquiry. We look forward to=20
your prompt response.

Best regards,

Nina Petrova
Procurement Manager
Email: procurement@mercuira.com
12 Marina View, Asia Square Tower 2, #26-01, Singapore, 018961
Phone: +65 641 1080

