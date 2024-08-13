Return-Path: <linux-kernel+bounces-284315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05CA94FFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B15B2433C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A213AA2D;
	Tue, 13 Aug 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xj1vI/bW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92609136E28;
	Tue, 13 Aug 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537507; cv=none; b=EEGyeE24tg7sFsadQef01gdw0m6S9QgvReVg2k3VVTsKsNyEIyybtRRUWWR1/FEosuDn2Eq5gJ9skahbM60qngZYhQk+mep01GPI3RvXUj1yYSeW1n2DKQ0D/2dfI1OiUOhlL2inJB/u83sU3BNRDInuLH/+uKdv6yuuSgsvwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537507; c=relaxed/simple;
	bh=L6unLVJiqbpBEamfu9nfLTH/noX/shgvhbWVpTWcweA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dec9ziqZwEiQvE6fKv9fWo0Dwlsdh+ONq42crohT9cUetdEp8Tn2UcuKEV/wgYHqCkHcd1FrL//Zku0VskhwRlRVG4juhqVxXgPtfZOGr72g2DMOkYyfwUfvE/KOZbNftBgwa+lhgEKBeK2ZewO7U4VBwriTQh5p/Y+6TGC9ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xj1vI/bW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37C0C4AF0B;
	Tue, 13 Aug 2024 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723537507;
	bh=L6unLVJiqbpBEamfu9nfLTH/noX/shgvhbWVpTWcweA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xj1vI/bWLuc0eP3umikPqW+I18CfcL6keSahFbTCOBOcUlxjWJMiL/DqlA3MdmpIn
	 lWWI4DT4bVfVu/RUZRZT+ZUAtSvksE1/2dzPGUX1zNTxZ5CRLXJvQZ9HMSJPAiO373
	 29+XbrHDJ9+VvdH49fdyti9stIqXzKVntBz5F2VE=
Date: Tue, 13 Aug 2024 10:25:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
Message-ID: <2024081355-palpitate-casing-26a2@gregkh>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>

On Wed, Jun 12, 2024 at 09:23:56AM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Note, this email address is now bouncing, so that's not a good
recomendation for accepting a patch series :(

sorry,

greg k-h

