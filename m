Return-Path: <linux-kernel+bounces-372849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1879A4E50
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C016286B31
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832827468;
	Sat, 19 Oct 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="ZU6em9aA"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D652F3E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729344715; cv=none; b=bgJF4o9JFgY8lmiH9EHnGLJ+iJG5D2F25oRj4jemd3HL/k6ki/xZZlX32mHuloZGjRkUFGw2U9/35PGqqphalRwYoSDJHMi/1b7/gZQMkECcJ39kheHVIl9nIqdyNQZHraaKAoknvxYht13gqIo17eaxELn7aRBaHnr26HBlwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729344715; c=relaxed/simple;
	bh=3uA+4Jqdwqd9dFB6jSaxZAZNklbfjMvVgVgoXH0QSzc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=F0DqTS5IL8ncK4h8sYWEuKlQjQaVib4OZEYc9uuSSfQwls2aBqy7fAxKup0upCXRPsx+nhVzBfYkNjUOfDxBFvVLornlQ9HyWasWfEBQahaK7m4FxCJT9P9FWz/Ceh543gmPlskKUGCkN0KY3DSPEnFAuyXICf3YtT/eGZQDXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=ZU6em9aA; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	To:From:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5TGw17weq5HY8ZColL7s69Slbc3Phl1/ZTJZ2ka15U4=; b=ZU6em9aAl6sYY1nv7bo136dnbo
	K6tPjGYVJN/sfzf6OVlwCTEFvFD/ocxL4SNyd1HQxi3Lcef4W2Vs+bM9Rtnazx1ZotMLi9Gj76JUn
	WpWKrcB9GxHGRuD9RbotjbT2YC5ropIm0GbACNRm/mL8rQ0m+sD/BunEp/kdt3MBRCaYem12A3A6+
	mbbm7wm6k56qgOQvwveWNpVEDhLk0kkJ1FQ2QAzxCGXXlV4E+LzF4LN23p1zd+O9k4LqaNmBY2fEC
	1K8XFi0rC9NzikLM3fPAGzRWYoYUh7BxshSuJwKXKk0iQAo/bgj7BrCh3OHRgqeV6EM245dQIr63P
	dWumVODQ==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=52831)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1t29YX-004uej-V3
	for linux-kernel@vger.kernel.org;
	Sat, 19 Oct 2024 15:31:46 +0200
Message-ID: <507f8cad-b815-4c4d-b0c5-108d7b13c1b8@bit-x.org>
Date: Sat, 19 Oct 2024 15:31:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Philosophy now Macro Perfect.
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
To: linux-kernel@vger.kernel.org
References: <28e46d4d-ffff-4b36-8c6f-84cde4fda72e@bit-x.org>
In-Reply-To: <28e46d4d-ffff-4b36-8c6f-84cde4fda72e@bit-x.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I do believe the philosophical groundwork is now perfected. I now use Im 
as divine, which is Macro Perfect (these concepts refer eachother, and 
now this is done completely perfect aswell). It is now similar to the 
original symbol!

Its quite an event now, this, so please do check out my page, and 
encourage Bit X, (as it once was about) and this philosophy background.

This is what will be necessary for a mainstream adoptation of Open Source.

Light.
Ywe Cærlyn.
Bishop, Bit X.

