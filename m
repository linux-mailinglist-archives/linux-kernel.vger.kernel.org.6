Return-Path: <linux-kernel+bounces-227920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ED915817
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7031C2212F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB931A0701;
	Mon, 24 Jun 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd18yy4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8B2233B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261444; cv=none; b=iOlk6prXXWLisPb2wKSxrU4zsVvQL+UGHKR/uDfAD/husOPkFZ1j8cega7S2Is8I7Djtdb5+ZvUonXKm5gkBoJU3kJsTV/MfxoM6/sI04bKxrRgbAbjX/zYQntHQ0ghzYk7PI4qzTPIcYx7R+k/fzkJ98iLsjL44Q6lkh/taq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261444; c=relaxed/simple;
	bh=KlGZU6SbZVmmg8sVqf2JRY2V0nEEBJ7yWWIFaAlAT14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8xbcQdpAgtuB8d+VeggYoTDlLUe8uigJcAsZxl/+T7C6yso2wmJ+98V8tFY0ZvxTvDy4wAsHVVNuHTsJ/tSWjYNVRzHMaEkWl4dm4n0AlX8+vKLeh/2Wp8tjZBLV6u03cgOC4Vzv1KSPJDHNzpu2Tr0Gk0xSwLFf/glwbVWzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd18yy4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F598C2BBFC;
	Mon, 24 Jun 2024 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719261443;
	bh=KlGZU6SbZVmmg8sVqf2JRY2V0nEEBJ7yWWIFaAlAT14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kd18yy4Ua4f/Ynq+/Q9OmliElNV2k3MmeCBwjuZmG6tFNTODaQ3gT/51T5EZV7CUa
	 WTXpVro70Wrl0HdQeO5Ct6DGTquyvhZ0syOJoWdayyiCn+xLs81NUBmhz+LCLceKzX
	 zEGNwVL3J+fb14ZG6kDyzgwTNnVF5MH0TbjpSCyU2pht5//LmpTm5+DDz5cOrp8gHl
	 YxmdFmTdxtBInthYnTm8LupOudPdnNu4os8SjA+t5YTpXYPj/ZO/egytaSAhpP3b0r
	 lDoQ7MBfCXsvj8Emh+l/esoExboH+6MQCYquJRPabsKOARB704l3nv7AoVUwg0OX09
	 i0JCq9qqFLIuQ==
Date: Mon, 24 Jun 2024 22:37:20 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] timer_migration: Improve tracing
Message-ID: <ZnnZAB0l8oGxZ0X8@pavilion.home>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
 <20240624-tmigr-fixes-v2-2-3eb4c0604790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624-tmigr-fixes-v2-2-3eb4c0604790@linutronix.de>

Le Mon, Jun 24, 2024 at 04:53:54PM +0200, Anna-Maria Behnsen a écrit :
> Trace points of inactive and active propagation are located at the end of
> the related functions. The interesting information of those trace points is
> the updated group state. When trace points are not located directly at the
> place where group state changed, order of trace points in traces could be
> confusing.
> 
> Move inactive and active propagation trace points directly after update of
> group state values.
> 
> This change is also a preparation to be able to split out update of group
> state information easily into a separate function. Which in turn is
> required to fix a possible race in setup code.
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

