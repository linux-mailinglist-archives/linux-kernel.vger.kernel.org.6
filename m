Return-Path: <linux-kernel+bounces-311613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6970968B27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C4FB21D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7919F105;
	Mon,  2 Sep 2024 15:38:01 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E9D1CB51D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291481; cv=none; b=YpgbcJOjhoa8d1+BPAUXM8sm/d32cyvgAazl/GG67AgDYeiP3tiAjkwOIdVcuKr49HS5aRODtzH83wBRvGYHHiFiZRco4NHzqHlUsO9zZBrFz/rUmnxXeLSNwP+QsUmPqd8cAFwnApD/EUO0lE00PRADqzx3b0UoA3vE7uW/8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291481; c=relaxed/simple;
	bh=H6he66atZJXJLujlFPm9bySrGSeGrmPiZocMjxtKOLE=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mY16imsc9sPmFlvBrJsEii+N+48PbhlWeanWjfaVpUk2qNt9OcIl66GYPZJ8TXv1bxRTb8kP7LEhtJkyK/31nS+N1xFRkcTq466w0vZ8rQTCV4WZpj6z4pcvXGjoSZ2ys2ufNekXK9PHBA4PP4NNXGfF4P+E2zSR1HuMoO/cz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2f79:eac0:e12c:6c11])
	by xavier.telenet-ops.be with cmsmtp
	id 7Tdq2D0080Z5ZN201Tdqhd; Mon, 02 Sep 2024 17:37:50 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sl97m-001qQr-1M
	for linux-kernel@vger.kernel.org;
	Mon, 02 Sep 2024 17:37:50 +0200
Date: Mon, 2 Sep 2024 17:37:50 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.11-rc6
In-Reply-To: <20240902151057.381306-1-geert@linux-m68k.org>
Message-ID: <3ce91c9-e4db-dcff-3af-cf902375fac@linux-m68k.org>
References: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com> <20240902151057.381306-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 2 Sep 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.11-rc6[1] to v6.11-rc5[3], the summaries are:
>  - build errors: +2/-0

Move on, nothin' to see (just the customary SH ICE crickets ;-)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

