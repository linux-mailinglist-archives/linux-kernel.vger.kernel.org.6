Return-Path: <linux-kernel+bounces-540198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC38A4AF5F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B07716C8C0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B21AAA23;
	Sun,  2 Mar 2025 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="pukX7f0n"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE123C9
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740895377; cv=none; b=P4sPGfxtEA5K4h2MMDEKlXiZ47rq+k3fEMaoeAXE2L/d+btG93svrUjBLo3jJaePgjW/5Y6ZAv+tO7Zk26IrVrOZT8HYnwNAeoO7mZGcaJSJzT3M7+7ho6s5Qv2Xwg3qlc9gJEDDZpcdlnLSfKe6cmQ40HcdkS7UrYeZCN7/vYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740895377; c=relaxed/simple;
	bh=Umzj/IL2JJCQpaSoY9ofBZ3j8e2BVso9RQ5uwThh+3c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lVrlLfh+fs+wmlqXwvU9uA6TPOPfvGzejr3fDnd4dbMikKfILbvxlMydZuNIQo07grMr5J+4Jm6gInmz0cGwxXs8QFtesSyeUrGr7eRwQuzD0VT+Z7OEPZ74Y9hYL9TyolugzUt4SBGHO4krK1gAeNjmu+2trhqvz+dHENDmG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=pukX7f0n; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cs+OKmRyRdDH03pJQ+3R7IAqgJnZaAOY/CFMWif1gvU=; b=pukX7f0nl7RA1CU+URsgk8lEHx
	yZVzS/bWZmv6Zk/LP3f3IEu5t8mZIhgdKzA41aukjnkY3xS7WJIcq+2nubSXyB1CvuPayqS/lzL1Y
	+qtczHKoV+0J6G0jb0B2APpu02B/0wpNn2cp36o/AadryPDKdN7XS3pxOXLxPL4KcSskhD4XtTQZZ
	4omTxZWY6idJSNXXi8TMfCHQcx1ojKRDse5j1t0RJKzQPB9lDqXps8o8asI+duXyJq0nAWzk+Dayb
	5YQe/R2WPs6DnivB3D47pK8ICDu94UyJjciMZ/8OH+NqjjJoDcSWrF5sudqU7wO/VrvUWiwwnbgag
	Ldz8Q3wg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tobp7-00A1HN-0B
	for linux-kernel@vger.kernel.org;
	Sun, 02 Mar 2025 06:25:09 +0100
Message-ID: <7a2be273-dfcd-430f-abfe-b2ff752c1a20@bit-philosophy.net>
Date: Sun, 2 Mar 2025 06:25:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe@bit-philosophy.net>
Subject: Bit X Philosophy (more transparency) (was Low Jitter, Fair Pay)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I updated to use Qud as the main concept of Ud, as is the word here.

This seems optimal, and resonantes with earlier monotheism, and also 
Iran, which also seems good.

It is the muslo (translated) side, who wants a good OS. (Crescent Moon 
and Star also resonantes with this.)

(Winos System = christianity, particulary "Lord", which is unused by me.)

Qud, Arc of All, The Real, The Right. (as my translation goes).

Which would be enligthenment in Buddhism.

Light.
Ywe.
https://bit-philosophy.net/


