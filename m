Return-Path: <linux-kernel+bounces-556316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9879A5C3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95640177431
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78825C71C;
	Tue, 11 Mar 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="rBGtR+sj"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8325C707
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703805; cv=none; b=FXWXwv3K2vJp7td/1iJYntK2WwYzoGivhFRq4bRnE14FjtIFoSVm0lWOMpcDsqNaMEq2IxX2iUDU2leEjkA3y4otRmjH+1XONHI6meZ/5NeR/wSZrRjeTSx7kmk2LE/D5staJfMXKZzGHsFRkEw9K67qsaZURX7aQM29tkZxXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703805; c=relaxed/simple;
	bh=JChFzk47x4Pv6YnmG0sIw2xJibB4lmYgbyQAy2NP0zQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=r/wAuQE8WBjK3e6gdVnYod2Qs+qnx241EzNBwUOD+94IgHlx/sNNU45BQz23y90WwAS4oe0gOLyApbdnm3T777lAeHFDw8NEdyS46GqQhP4sMPD3LZIW6IyI0knUzRydtitapqn93LMBCS+xDp3LK7KOuHLnBysZZB5eY2OC/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=rBGtR+sj; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LmEeT89AJKotBCJX/pJFpSI4PTp1wz4cUlwZJ/6NWfc=; b=rBGtR+sjFMkdS7sLNIlxjSxU1S
	SeCH1B3PxcyKuR6ffTY4MlM++ocN1r+2iSazgfbxrzf0WL2gaOh8G0QoL/unO8UIF9Db/wqy+c5oQ
	qfUSckBd0ULkldQ7dfNrD5iRVleLW6XpuQ5pWTF8eylK1mkUR4GBS6ibYMLAWOsMlCZyS6ftXmAYY
	at4i7T875pM/5TKHIdtr0QNeTbSWEMyC4QMGvTAHNWEqHNKe6zHsPjAICqpqA1aJQ52ihopc/Xy3y
	Oyytgbua/lEAhc6Xckm140M7qAkzqzYVzL7LvxdYUvMSdcg0MS306VW99p8zxShD/JRWqx3p1pKzW
	5YvM+YGw==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1ts0ii-00AiM9-1m
	for linux-kernel@vger.kernel.org;
	Tue, 11 Mar 2025 15:36:36 +0100
Message-ID: <84432894-3108-47b2-89a6-66be32ee6351@bit-philosophy.net>
Date: Tue, 11 Mar 2025 15:36:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe@bit-philosophy.net>
Subject: Fixing Commodore employees foulup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Commodore employees rejected muso (mUSLIM) manangement.

This led all the way to Bill Gates drinking feces water (HARAM).

We can undo all this, rejecting the chain of events of it, and keeping 
the correct chain of events.

This means ACCEPTING muso management.

This can easily be done with rAFI Deva!

Light,
https://bit-philosophy.net/

