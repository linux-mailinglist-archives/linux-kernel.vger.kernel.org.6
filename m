Return-Path: <linux-kernel+bounces-295171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BBA95981F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26821F227BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8361D679D;
	Wed, 21 Aug 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="m6DfmStz"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CF1D678B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230541; cv=none; b=R+YkJiUaEpsTjJ74rRjxgqgNCAzdWDoub+vZLF2jLFy+2T9nzu6e7FANjYMcoRZyX9hqXXayPccyDItRn6PyuBeV3D/JJ1vZorKBM5kaqP94ee+CEmyuY+HulMFcJjCZhZ36BW8RM76pT65TM2bZ7i8l8EsH01Ih1h3LpTauYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230541; c=relaxed/simple;
	bh=o4c4KiRC+QMVlRa7dGLnOI9p386YzZWBURAG+bkEGf0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M++dRUJVzPhc7A3OCd9T6AIoE3jJ/H66rBiFaBxM6yf0DbMB7ap5jQcx4ZqhLGQ6EJiS4aXChIyvb+PNygZhoH/9j2Ji2HzeInmdt4mKgi0GdavSvALglDwmn6b7tk+iC4ibsHCHN+o+Z1dv0f+LpZ6NZGiYkhOzH2ILOdzteEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=m6DfmStz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724230538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5+mhHoQRTBRXRWrYFtxPdPmjZzokWCEndZVOtR565Y=;
	b=m6DfmStz8SOfq5zC8n1iqsMD1H19KuNWrmoKefRudJe2SkRfA0y5bX/XXa4rrZVRZ+6eUb
	fhTu99IP0+sYoeXAs5dGU6hk3Z0JirUAhpOMWvtcE+aN5+z/gn8u2/anp4jSzqNa6lSvi8
	8fBcf4z49/bRRjAVWUM+seXMepVHObDXjV8HwR8f6xOh8wHGAKz+N9GpXRZ3t+0tCeYKIu
	DUCrbTxs51/FT/yRKtRqKcgIfWT0BNEdRLR5y99K8XG1H89jkoHqTkl47ulw780M7f2zhL
	m7RieNEze6AZNPDpju8msLMsOmJoDzZ6Ji3fg7IAKJd/brqK8obynNDzMOpyUw==
Date: Wed, 21 Aug 2024 10:55:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] phy: phy-rockchip-inno-usb2: Handle failed extcon
 allocation better
In-Reply-To: <39189616.J2Yia2DhmK@diego>
References: <cover.1724225528.git.dsimic@manjaro.org>
 <96200baf794a0c451f3bbc3f5530b8cf0e359dfc.1724225528.git.dsimic@manjaro.org>
 <39189616.J2Yia2DhmK@diego>
Message-ID: <8f1f70ffdf5f52347c47cad31bf0a7da@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-21 10:41, Heiko Stübner wrote:
> Am Mittwoch, 21. August 2024, 09:37:54 CEST schrieb Dragan Simic:
>> Return the actual error code upon failure to allocate extcon device, 
>> instead
>> of hardcoding -ENOMEM.  Use dev_err_probe() to also log appropriate 
>> messages,
>> which is fine because the containing function is used in the probe 
>> path.
>> 
>> Helped-by: Heiko Stubner <heiko@sntech.de>
> 
> How did I help with this? :-D
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for your review.  Well, you suggested that dev_err_probe() is 
used. :)

