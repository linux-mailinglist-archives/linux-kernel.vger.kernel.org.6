Return-Path: <linux-kernel+bounces-235244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37691D230
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB9B1C208A7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3263D153509;
	Sun, 30 Jun 2024 14:59:10 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774412FB34
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719759549; cv=none; b=Q51pYB9373xoqcyVG/I+Mbq6fX9LNR3agA0LlenmeguWFzXZ3Si45pYoRVBIkyH33GEQ/D8uSMwwZaPopmEv2hJCpr/dfhHzJD0yKPANB9sOxO29iJNecdakPTwDMQ5UnPBx6KQxej0wHPitFPg/4FIbztZB9BhGDQdpo1OxoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719759549; c=relaxed/simple;
	bh=XKHtYxooikSnL5CMC/rfdWIF+4z3DHczOc5wbZ61cNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbhyt6k3bYNJcZHmc03JiLJ/552M+gcNAvXBHeCJhY5L9CMvIF4whvBK4CPmCaaW6i6xYAzC2wO0unI/XL1fRFeR+YSMq3KfnorFAv9R3UL4sjw769fAWQo6G61j6+Zv9gH2Ax4fSfjLijp1ol/rj4+IwaY0216pPhFzyQkMUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 3069E2002D8;
	Sun, 30 Jun 2024 14:52:15 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id CBBEAA0088; Sun, 30 Jun 2024 15:35:09 +0200 (CEST)
Date: Sun, 30 Jun 2024 15:35:09 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Use resource_size function on resource object
Message-ID: <ZoFfDd8NUXgfPxqh@shine.dominikbrodowski.net>
References: <ZkFDOcgVxnnzX_bu@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkFDOcgVxnnzX_bu@octinomon.home>


Am Sun, May 12, 2024 at 11:31:21PM +0100 schrieb Jules Irenge:
> Cocinnele reports a warning
> 
> WARNING: Suspicious code. resource_size is maybe missing with root
> 
> The root cause is the function resource_size is not used when needed
> 
> Use resource_size() on variable "root" of type resource
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Applied to pcmcia-next. Thanks!

Best,
	Dominik

