Return-Path: <linux-kernel+bounces-236350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6791E0E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860A4281380
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784CB15ECCE;
	Mon,  1 Jul 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC6HqR5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F582C8E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840976; cv=none; b=OQgeU6c1XXz7Mkhle6kTcVrCwo9Yixpec0bYiMqkPFRpIQsdZOhzYDBFYiJmNiWeKsLCI88bEwrpNaZgJCm6dS/9ksSBikn3F/BLxaRWWACRNxom1v719A8J9+q8tmPHUyd5O6kgDSR28rzvrzGp+364Wpoi6eEGed0k3nBWrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840976; c=relaxed/simple;
	bh=IyKj2r7YH7W35QQg8S7BTDhhHquZxi+k9qw6W/UklM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCTTvBNZrQ383g1rmb8U2I5Oidv+VNhoHHH6T2wAUP63SA38H0oif1xSEwe37B4yLyO964KIwXFZtsIptXZkQCFTiYZfEUVncl3NmIpdphXeJYSilKokbbH86R3aRs3F2+8pl1lC/58eVRlUI/eKlvv9/YQTdb1pmm48BkEsBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC6HqR5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89964C116B1;
	Mon,  1 Jul 2024 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840976;
	bh=IyKj2r7YH7W35QQg8S7BTDhhHquZxi+k9qw6W/UklM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sC6HqR5CIgbDuq/GvhXAjEK1ujQ06d36jvdU+BFRGdCM90kmTE/dbG6rgyL80eQpy
	 Cddb768m3ioZhKC5LLLNzaC3Pp/vnuz4FKi0vK+Yx75CSpbYfWNHPFXu6Z7zeTf6ci
	 EN7M0TF0Fwtl2zzSnxllxZ7Uf2Dw6ESXghb/X/qJq2bJ7FAIUcgTY4ZpWjVrnP9YZk
	 7l7xpv0TBYX9QYMTzZOOqZU+aCzNpaXYHVxzvnSycFJyfdcLRnmjj3lfwYxhXnPMc4
	 rGMjx/E2INs50FYG45pKN4600WcKFEOWJmoYMyqgoKv/flThchTLBEJfRyPIujD+n7
	 F86wnylyHw1pw==
Date: Mon, 1 Jul 2024 14:36:12 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
Subject: Re: [PATCH 0/3] perf: Add Arm Network-on-Chip PMU driver
Message-ID: <20240701133611.GC2250@willie-the-truck>
References: <cover.1713972897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713972897.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Robin,

On Thu, Apr 25, 2024 at 01:29:51PM +0100, Robin Murphy wrote:
> 
> Somewhat later than hoped (sorry!), now that it's finally had the chance
> for enough testing to flush out all the silly bugs, here's the NI-700
> driver I've had kicking around in various forms for the last 18 months.
> I squashed in NI-710AE support since that appeared in the meantime and
> the differences are minimal, however I have not felt compelled to go
> back and genericise all the original NI-700 references. I don't think
> I'm giving too much away to say that there will be further new product
> support to add in future, so I will be back with more soon enough.
> 
> Note that the driver patch depends on the the cpumask_any_and_but()
> addition queued in arm64/for-next/perf.

I left some minor comments on the driver code, but I think this probably
needs a respin anyway as the binding is still pending an Ack from the
DT folks.

Will

