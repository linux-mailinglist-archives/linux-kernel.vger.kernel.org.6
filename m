Return-Path: <linux-kernel+bounces-207479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66A49017DB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663C1286583
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B84D8AA;
	Sun,  9 Jun 2024 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="KF5sXPuG"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C547A58
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957601; cv=none; b=pGkRA6mhOlXAcCcab0RjDDtQe0sL+cRV8AkSI7hR3++cZNYm4CbWhQzj6nzvgFVYGtZtXdgRRUyYDYRbkrhuEWcw8QljlGNcl6uA0dX8keMxWT8B0BQh8gklDzqRF2XT9CkQbpbkV68Yw5/1qSRtlYXm/FDP7Yui5SqnObTTLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957601; c=relaxed/simple;
	bh=wDjz1xS9njWgW1lw98vb6IMYdSn2Cn/j9YQfDTvjPiE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=sjj/Ol/awMiEmQzwzWN9A+eUP9S+/K2nTu5PKBxdO1wcSBzsehmWnLLL164vAOgYaP50Zn+EIVoJwRvD88tKlHwQSe/0VEDsy/mRHOjRYd3PAUfHubsUocmZS06OJ17rnvHV92twPAuKWlY+vPLNEhT4aYiPlv8vmNQuSLY8bWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=KF5sXPuG; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/V3lr3I7tiTJFIjfzJ1m10mb04NGxg7ccphiZ2gCauc=; b=KF5sXPuGXZ8tQ8LtA9I48Mk26/
	ZhMSWTbHUjF/pqouA3HAhPXNPJ9sQeYFSJcDYSu92q8GhO9JgGi8ebQvNf/bI+0uvNf5uWNQdQ1k7
	2Dm0/H3I1+V2qK3Z75zd5d58Ida+4hYwycS1evfCLeyy2HCUdSIA19e9kgpyUNbL2QYKttkMkzE+v
	8wshHHGjCaLnsYYADWkwblVOIaX9GWQ7BwzxbU4etLwQOtAkE6QPbKt5TEKcXVA31AXTKYmx2Na9e
	zV/C74+3BjP5ZdIpqJTnxqXcVe1x7FK21mEi9j6UseWg6WF20TSatnhlOCBe/cGlDfwwu0nAjTiIi
	ssvmoLWA==;
Received: from [2a02:fe1:716d:5f00:1029:6f42:5d4e:2541] (port=57677)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sGNFP-000xCc-KD
	for linux-kernel@vger.kernel.org;
	Sun, 09 Jun 2024 20:26:31 +0200
Message-ID: <5e42a9a8-fd5f-4252-9550-0e10d59deccb@malaika-12.net>
Date: Sun, 9 Jun 2024 20:26:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: The One X (unix) vs The Vast X (Fair Pay Philosophy cont, was Low
 Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A comparison:

The One X (Unix) is from a Bell Labs mindset, expecting pay from Employer.

The Vast X, requantified for Open Source, prepared for income VIA 
(particulary) Bitcoin.

The Light Be With You,
Ywe Cærlyn
https://the-vast-x.net/Ruhban/Ruhban.html


