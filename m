Return-Path: <linux-kernel+bounces-367326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120049A00F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0D81F243EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D218C01F;
	Wed, 16 Oct 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="TCDXK/xj"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A118C01A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057924; cv=none; b=RkbMBV8t0omO0TQuZtuQp8/eDmhqiXEJeledhz0NUI9iEKcljZvbq6J0RpBqqO8EiiivY9ANjck7C2sDNCdGkxi4O2pZJGfod8REovujYiqLNccr41/XUWc+/YLvxJ/9gwPBQy/RyZhn6Eg/2dvxMBGTb9/U8LCZIsz3dA7UI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057924; c=relaxed/simple;
	bh=jOmrKT15a3M/UtB2gZ1bYyDH3NoZChSwG7GQfB99KyA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Dq/Hg74ih1ZFs7G/ixO4vprq5JDOjfLWUUidm+8zoUu7HG1gqbLWaPDFCw0uOdALcd1QgCfXZFiJjeVyw0ANQJl6wXXtxyqjf5QxQaF3aXjdBx9Xi7QQLzLL8YMDjIGFI7uaV4TVusoc2wnAI42w8F1eYhjjC2dkb3hY9t9Hf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=TCDXK/xj; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e6HhxREtBmZUYkjkc5qFjmWv/3lDWxGckb3h4NN9yxM=; b=TCDXK/xjYyAHgGA8aSvrIev60l
	PYIYMdSbn9fom0VanZftjEevZQylLFG7PoNC5IH3pjRIItaj6vC4MHGikVUjeBT1JWuYwXkfjh9jB
	3CSebVXD5Ao6t3ITrhUFFwo+CmegSAEjoFQw/EjeyNnZg9kJ5x3YL+R+kIQP3A0ipPu+G2M5Q7kBc
	mJRJv3brrmzP69NHfcl+Kq2mFfPvkWr46KH4PKQwK4gnDKwBQMp009huHdRvcehQ+gEUOxJ9uRnpJ
	yUBuIPjAVcTo9hFD0ryk0NXySyfx9AICcjKO/o4ytUWoT/UFmHJFP/IfaHcFeeHsAXdLpAigiXKQe
	Tkq7Ie4w==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=56265)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1t0wws-000EZh-9k
	for linux-kernel@vger.kernel.org;
	Wed, 16 Oct 2024 07:51:54 +0200
Message-ID: <28e46d4d-ffff-4b36-8c6f-84cde4fda72e@bit-x.org>
Date: Wed, 16 Oct 2024 07:51:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Philosophy now Native!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I managed to refine the philosophy to a native viewpoint.

(cursive verdana) Di, Rev Alamin.

And will also see if I cannot do Shuaib Restored, a translation of the 
critical and native translatable parts of The qURAN. ("Ash Shuara"), and 
retrofit the prophet Shuaib to this.

This will be background philosophy for Bit X, and the angle needed for this.

Light!
Ywe (in happy mood)



