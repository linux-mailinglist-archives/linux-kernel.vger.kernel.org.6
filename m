Return-Path: <linux-kernel+bounces-239959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B30926743
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DA31C228B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C51185084;
	Wed,  3 Jul 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BD7dDmdW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FED181B9F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028132; cv=none; b=SIxPrA8NFndQ05Anz0MnBXOZAn31TzytqFeG+QwaBr2B0aG2Ers5y1X3S+aTnNas1/nb7e9Ou1GDrFlu6SAj7XeUjEqvzt2N2Y2J4ytlv3c1Yb63/Deb7Pnf+94c/cEWiP2d0niKrsYxmuPnOhD1IC3cpFPph69AhA4AEdx6tSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028132; c=relaxed/simple;
	bh=cEDRmGcD2YtDd+eG9/ZYaL79MQUOc3JyQ/cxXiEje1k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iFlcUt0K31n3WiBgwB2T481a+epEhXNHh55UE2t7vAdwfHPM11lkXDUJQj6+Tll6JS04Usmyo63iIts/ArZzZBFh/J4jQ5a5wiiZeEhbzfQppTiF9T8mCYBEZG9A5rSAStrrn77FCarpBnTOcCpVJ6I4oHsHKP7cWV4jM5SmU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BD7dDmdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2377FC32781;
	Wed,  3 Jul 2024 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720028130;
	bh=cEDRmGcD2YtDd+eG9/ZYaL79MQUOc3JyQ/cxXiEje1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BD7dDmdWAVcCW3P7w/8WhvofLc6zf6m+NlHLkqF9UAjzqAV38cyHoqS/MthPAb7Kv
	 jFfYRtSGdmf7Ts1AWb6vZ7Z35fnm/GXYMZq3iGwvu0P4ThKRffOhtOObTUHZQo/FwF
	 Y70MD2cWO5V4iG823FZw5QckC1kqd+MEord06uA4=
Date: Wed, 3 Jul 2024 10:35:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Nicolas Pitre <npitre@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
Message-Id: <20240703103529.2283c3c4683c60f1ae50a152@linux-foundation.org>
In-Reply-To: <20240703033552.906852-3-nico@fluxnic.net>
References: <20240703033552.906852-1-nico@fluxnic.net>
	<20240703033552.906852-3-nico@fluxnic.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jul 2024 23:34:09 -0400 Nicolas Pitre <nico@fluxnic.net> wrote:

> Verify that edge cases produce proper results, and some more.

Awesome, thanks.

Do you know of any situations in which the present implementation
causes issues?

