Return-Path: <linux-kernel+bounces-177244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522B8C3BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AE1C20FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7E146A7E;
	Mon, 13 May 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="K1NvL5WX"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245551FA1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585005; cv=none; b=ehJmYisJx2R4GbrBLte1iUsZOj8S7xb2feo6FGiWF6mA2W4xG+6dQJhQ3QnShkddGy2XLVlxDGGEB276wG19WgLXHRg+AtdpNt87/QyEt62U1iY4+4crnzgQNsIqKstpVkWoBVnG9QQe9XY0ED9gLdMUAbv2QxcRuIiTBJyOH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585005; c=relaxed/simple;
	bh=rQJujlGNHZ8JtOAZLkV2s1QCN6TXGMwoHchPCU8aLyo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=S1YHB7ktxPCgDOnN2jZcnVpZzIFv2cuhh9eEba4JC4t95ATBJik0lqAjOGTlzHKfapRyYPgwuZCU4KrQXBQGP6xdOHkySuaToRmE0zq6JVVsAbIsNkV0EKCvXa5CJ2dpVyXm4foVMWzp27gPplYNOJ41Y5u+7TBEjlApZUDVkKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=K1NvL5WX; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6pnPQQmX7ZHdP6moaB8hDwI5scn9DEZ62685rUuHSCY=; b=K1NvL5WXoW0TmDLov5A5Gdzww8
	xTTeOa2rgDhS82NuHV8isgegJkWePE1vhR3tRnDH992WxFubpOY4NYzmPd1YX2exzbri0feeTOrZs
	jrnnPU6JKgaF+wD9EL6mJF+aZE7YfQozVTS4b+taIf5eXMC+82Ubw5BYn/hFyJnvi6K9S18Yqr9Lf
	cTa24wJ2Cu7GW02mo6f8RV6ryL6bIctcGXghqklkBrYn4SR+tYw+Yq33DtzYp8n2wAMDlv5Z1obpW
	IFQANf7dyK6TTYRipwUZf2uervMRlGScb177qdoWPltzg45ayTvJd+bjNx/0hc/z4uHctY93mzvmn
	QxAjWAqg==;
Received: from [2a02:fe1:7001:f100:5b8:9541:a8c0:9645] (port=60045)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s6Q1o-006hsV-SH
	for linux-kernel@vger.kernel.org;
	Mon, 13 May 2024 09:23:20 +0200
Message-ID: <664dd5bf-6bd8-42e7-98b8-eed814375884@bit-x.org>
Date: Mon, 13 May 2024 09:23:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Bit X, Mormon Fair Pay Philosophy (Compatible with Shia, Ibadi, Quran
 Alone)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, the philosophical background is perfected, mormon based, and 
compatible with Shia, Ibadi and Quran Alone.

This is a wide basis for Fair Pay, and correct political measures.

Further refined my summary on https://bit-x.org/BIT/BIT.html

Hail Ol, The Grand, The Good.

The Light Be With You.

Ruhban,
Ywe Cærlyn.

