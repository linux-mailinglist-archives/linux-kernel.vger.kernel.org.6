Return-Path: <linux-kernel+bounces-268862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8228942A66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3EF281A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3E1AAE22;
	Wed, 31 Jul 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Ig9VbEwf"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAA8801;
	Wed, 31 Jul 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418006; cv=none; b=qZvcWZ9Wv1JuadcJPSoKhl9QBuxPN+yCd4+DSW3SMvik6TzNPVeuIvvigxt+xZNOJtgvzqhPHNq3LdygwF0qDKrPFATIcjbpqSoKGGxMWUXDAwxQh/scVZrBvnSqV0wposVX45+1NPQ8QS0F0+EkcCdMPXIJqTd/SDEfiEnhANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418006; c=relaxed/simple;
	bh=eJESnb8j7UvJgQTFhBVqMj4+D94rZFUzBFaMUMtmv2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQLmzyucGZXLXy8k+OIoFlpH8bdksmXAaSFTYFO5Nzxl/owmgzxtEe3Z12lXdbNCisTj7nHaM434k0Vv6k4fcvBYmYlkQE2WRw3t06efjR9BXTj7K4CwCf1O82mRQhJqn1FPNZsdxTTui+6s4ubh4GbDUkAanJNfn/a7CH/uoWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Ig9VbEwf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DFE901FB89;
	Wed, 31 Jul 2024 11:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1722418000;
	bh=eJESnb8j7UvJgQTFhBVqMj4+D94rZFUzBFaMUMtmv2s=; h=From:To:Subject;
	b=Ig9VbEwf6KhGOo1M3kaqPulIuDNirXovJzVevSatKMAKfxfzaoUHb3Meov9bR6ZP/
	 D0mbQylQqpIcI44zpQ/ac9YRbObF/L4eM8Lu4uDcrAjSR7fxsomVAjDxJMJ2fjey/L
	 iuWLU/huUjnSW2CEoWpsSHDzIKm1e2tFRQA/Iu4bsO/b6MI05EhLdo+LvY0J29/fjD
	 V9DQxPBl+V/lDBbAoWCZpy/LyDvPcXn41FByALwdJZ7qc0JBdT7sRUrlrgWMtmxROf
	 H96iUDLXK7/El+csI/dgPEiRAFzi/gDb6lB98MASXOsEErLvanjhfJWv1C6CNQtIVh
	 Elswsb6TRWnbA==
Date: Wed, 31 Jul 2024 11:26:35 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Input: ilitek_ts_i2c - Fix spurious input events
Message-ID: <20240731092635.GA32718@francesco-nb>
References: <20231222183114.30775-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222183114.30775-1-francesco@dolcini.it>

Hello Dmitry,

On Fri, Dec 22, 2023 at 07:31:12PM +0100, Francesco Dolcini wrote:
> A couple of fixes to prevent spurious events when the data buffer is not the
> expected one.

Any chance you can merge this series or provide feedback on it? This is
open since 10 months now and I would need some help on moving it forward.

Thanks,
Francesco


