Return-Path: <linux-kernel+bounces-554737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C569CA59BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107E5169346
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0048230BDF;
	Mon, 10 Mar 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn/FsdnM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8A230BCE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625929; cv=none; b=NMNCl3O3H9q5+dALJqrl+7UT7NIVMZbKGp6yN/HRuhonEs2Q+MfcwRrsqi6YJ8bJevVNIZklguw3jIzQ8bUz+Fq9rlcQ0r9vxRffVddIluGhbQ8z4z3/rumta0ZTlXin3Z7fB6xiixmjPOuN+tWGTEDfk4YCyYLzi17lPPxNHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625929; c=relaxed/simple;
	bh=gvhMWpgJECBLHsa0YvEDKB3j74g+sYRpOsZes8lhFSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUnD8CAp77pM33zXZ8D5lnHpq0juVfXw55mk5edtJoeanE/3qyZrIG3nv/J0Z4t5NMfdW5WnF0mbpDUYcHjaAdDsEbfXerVh5tZOFO2iciwr9y27IV3JHDfbuUb9maujBJXy88zLU3RAYOFmNRVjLNoRkpYljyl2JVwzC6/UlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn/FsdnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB80C4CEE5;
	Mon, 10 Mar 2025 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625928;
	bh=gvhMWpgJECBLHsa0YvEDKB3j74g+sYRpOsZes8lhFSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nn/FsdnMWtQHyQkBm865Z5IwjtHEWL++FITXB23XyTxfqsbzkgxCXekJixoYYvptL
	 dVnZnNrr0fMKK4ULJw9U0SmQpESabuSg1ug9Hi3hI9C0qOZ1IndkCMcPRBcrrd8agS
	 2MNvg0TmYFz1nNCRBzM1f7NV07MkVL20Xs397bVQ5WNuhPClx1LvobQy0LpsSzLc4z
	 oyTgWh6MLfxp6Ot1cTo76QFvES6lP9V7NBRE5bL0bcn3WaUtFnghvnohABg8XALPO7
	 vUBDsIxSvsyQo226KATJjUNpz7crRZk9Fu8AR9rXnd2msbNdjd1gFFRD/wf/IJYDfp
	 8PZLGeiIz5uEQ==
Date: Mon, 10 Mar 2025 10:58:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jianlin Lv <iecedge@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jianlv@ebay.com
Subject: Re: [PATCH] nvme-pci: Remove NVME_QUIRK_BOGUS_NID for device vendors
Message-ID: <Z88aRU7Bq3SYtyyO@kbusch-mbp>
References: <20250308141102.34101-1-iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308141102.34101-1-iecedge@gmail.com>

On Sat, Mar 08, 2025 at 10:11:02PM +0800, Jianlin Lv wrote:
> After commit ac522fc6c316 ("nvme: don't reject probe due to duplicate IDs
> for single-ported PCIe devices") merged, vendors no longer need to use
> quirks in the PCI ID entry to work around the issue of duplicate IDs.
> The NVME_QUIRK_BOGUS_NID flag changes the format of device attribute file
> names under /dev/disk/by-id/.
> For example, /dev/disk/by-id/nvme-eui.xxx -> /dev/disk/by-id/nvme-nvme.xxx.
> 
> Considering that naming formats need to have high stability and
> recognizability, it is more prudent to make changes only for rare,
> sporadic cases rather than implementing comprehensive changes. Therefore,
> this patch remove default setting of NVME_QUIRK_BOGUS_NID flag for vendors,
> and the flag is added dynamically only when duplicate IDs is detected,
> as implemented in ac522fc6c3165f.

Setting the quirk on demand lets the first scanned namespace export the
"unique" identifiers as their own. Scanning isn't deterministic if you
have more than one, so you wouldn't readily know which actual namespace
a particular /dev/disk/by-id/ link points to.

