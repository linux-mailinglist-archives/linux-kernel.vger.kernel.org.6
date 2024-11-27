Return-Path: <linux-kernel+bounces-423978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F19DAEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6DE166F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DBC20125E;
	Wed, 27 Nov 2024 21:31:31 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833414EC60
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743091; cv=none; b=YC5VJEZEiELGOh+T9ycO5Z+qF5V1+b43E3OmQY4mJ1xb6CJL4dJBQ0f9kCJZVZZjY8ilOOI4X10UsTA8KLSagGy0bOc1wktdMsR/oIzfN1XTPbnfolsX+JfA0ENljk3WkWNw6oARL8FAeA6rc/fMpTWSJdDaDDHpo1TYQ+SbVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743091; c=relaxed/simple;
	bh=CHi7bphX71qYgHTlDll+Wj7NJLrP+YAEEOXZpEaR8DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjBoOgRkm3YDG7itUYZNx32OHLTr0SDtibbLBAOiFiGXkLSodbPsnuVF0gLJRlwOp+PcMAxcW9wUqpeg68AZh48sGmxSRLnPYLMoj0IsdO8sd+tYA22uXSY+J3CoU52tRlQitQYFQXaKVavcRwxtDNkXtSubfYrhohzZz86EGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4ARLR3GW027113;
	Wed, 27 Nov 2024 15:27:04 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4ARLR2qE027111;
	Wed, 27 Nov 2024 15:27:02 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 27 Nov 2024 15:27:02 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, jk@ozlabs.org,
        arnd@arndb.de, geoff@infradead.org
Subject: Re: [RFC PATCH 01/20] powerpc/cell: Remove support for IBM Cell Blades
Message-ID: <20241127212702.GP29862@gate.crashing.org>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.4.2.3i

Hi!

On Thu, Nov 14, 2024 at 11:50:50PM +1100, Michael Ellerman wrote:
> IBM Cell Blades used the Cell processor and the "blade" server form
> factor. They were sold as models QS20, QS21 & QS22 from roughly 2006 to
> 2012 [1]. They were used in a few supercomputers (eg. Roadrunner) that
> have since been dismantled, and were not that widely used otherwise.

Sad to see this go as well as native powerpc blades just days ago.  But
yeah it is time (and we are all getting old, etc.)

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

> Until recently I still had a working QS22, which meant I was able to
> keep the platform support working, but unfortunately that machine has
> now died.

You're only sad for sentimental reasons, I hope?  :-)


Segher

