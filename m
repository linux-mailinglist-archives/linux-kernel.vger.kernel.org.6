Return-Path: <linux-kernel+bounces-308972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ACD966476
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766091C239DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832921B3B35;
	Fri, 30 Aug 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moabit.uno header.i=@moabit.uno header.b="kH6ZyPXj"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A71B3B20
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029325; cv=none; b=jqlHGlzxT2x4FSC2wTvGSATBKWimd6SJrjTgsigj3THm5rPkVWK2MKT7Ac2rTPKAmJtZeRo9+oLWz5yXHHfUH5dRFlO+EVQnP0o2G2iR3cxrWZhWlmY6NqTuRPI4zo8GZleF1m7ZkZv3Xa+oZzc0pqkdrV4LIqQDrvYvmiGQ0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029325; c=relaxed/simple;
	bh=BvviuxMzC/2sCCZUeaCqp1OARhWs56qzTiU0BSCKBgE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=evSzh5b4hEMLBZ74H/FSnULzqBwajxqC6ZprWCb8ZnFJRXNmeRE7qQNPMiUpl+w7ODQXOK+gi/nYx7ZZ79f08PXTSd7cbXZ6uw2EiH1e7W6q2RlM30wgCkXA9L1VKxBv58tkOJQUqwRsqLXfZMhqr/ERxqM8zKB+96r4vByMCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moabit.uno; spf=pass smtp.mailfrom=moabit.uno; dkim=pass (2048-bit key) header.d=moabit.uno header.i=@moabit.uno header.b=kH6ZyPXj; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moabit.uno
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moabit.uno
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=moabit.uno;
	s=ds202408; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f2pLnwTHqYxHH7EX2BMVA/PE7ZiG5X4YTTkLXE2FrjM=; b=kH6ZyPXjkPx5GSJES4lqS1Ue19
	KJKTkE9cPQu9MzB3nqk6AwNnUj2m1EDjYzsME2sX0LbK0p5iBE7vCCAjvHp+cAnSXVb9ZT+rML6Ce
	ZZA23t7rOr2Vc6S2VLCFkybB6LTuQad2ff2gQgtlWAWlN5mavJcLcE7GwNe5d5RGYdnFjoDHMlNqQ
	J0GD8yqEWupm3yTMY+TBGiBiQP2Vk98Blw84iraQDzqtiaVtJ2cCqpPNMcBvzZxJwRnwG7SG4uh7o
	/AsjNqKbWLbhHUGZECX80vnpK+u07Qtl8W9bhmJEsa+Aarph2Q2aZBWQV9ftYDR+kgZPvxcLvso1+
	GyGTMXwQ==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=50019)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ruhban@moabit.uno>)
	id 1sk2vU-008Sv9-Ak
	for linux-kernel@vger.kernel.org;
	Fri, 30 Aug 2024 16:48:36 +0200
Message-ID: <0c0fb1c5-f6a4-4e92-93aa-8e1b27e865a5@moabit.uno>
Date: Fri, 30 Aug 2024 16:48:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ruhban@moabit.uno>
Subject: Ra Net (was fair pay philosophy, low jitter, red poitics etc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ra is a normal dynamic for an OS. I am updating my OS concept to Ra Net. 
It really is only this.

Consolidating all of Fair Pay Philosophy, Low Jitter, Red Politics into 
this.

LIGHT.
Ywe.
https://moabit.uno/

