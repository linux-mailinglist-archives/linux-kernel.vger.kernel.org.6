Return-Path: <linux-kernel+bounces-549692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA266A5560B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72471896A17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC026D5B8;
	Thu,  6 Mar 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZBLODjs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0A25A2B5;
	Thu,  6 Mar 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287343; cv=none; b=UlqK5BES3ywOJEunS9mrgR6RqVhVckwcKLj2yk49yYXaXtTGZOYfW3N/GqnOBeEzVoLnSif7Ukil2p+2gTMZd0LSlJYKnnB/pxZWpWIQzZhE8GzloaBfZ2iAGzlN30jI9xVND5VxVARImVNCMlGjuX7SB/5MugaKcx+knOJrZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287343; c=relaxed/simple;
	bh=Ub7RzuXcYpSUTmJi4vJSeDmxShrI3yEB4KiT5V1Ku7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RSPa7HPedm7kSJsBHm6kkuXNWsI6H4s4mH9ZlETHT66QabwAiDve859tfKD0uv+LxDXfMAmxfMRcV6tS0tdzqHVLldjUjxkScZz0n1aOMi1JGH+iNG5C5iuYpO07NXfrp1GemTS0PcjDccYRaMOzguuxVaantjzs8tux9oCsujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZBLODjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7303CC4CEE0;
	Thu,  6 Mar 2025 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287341;
	bh=Ub7RzuXcYpSUTmJi4vJSeDmxShrI3yEB4KiT5V1Ku7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IZBLODjsE1Rk6eXY6926ZZLOoET+x/Tl72I1wSZUnjq2iFdd1+6cbyRmsKT8nlDAO
	 h6FDCD+FewLVt2LLMaN8NUtQbnZ/3snVXul9Ox5o97CPxu4cTHk6+8jhqNLoWP2RLO
	 tJYsNzUuR+l++rQIutqrr1EKSvYP98IW/fotYszG+KJ4wyj7wN7oNKT/UwGPyxxS92
	 QUIUURurvH70+x1lwXrOdGJsavBa/e72kTyAnlPdk0ulHXGHa8W/dQ1G4TuTt2GcWE
	 ejss0+9RLa1UcnZx5rQgCE4oa6JniOyQhvaYrccCdsEQnjp8mMuC0cNJxVccM0gnOk
	 OpA8SjL+6chmA==
Date: Thu, 6 Mar 2025 12:55:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, lukas@wunner.de,
	alex.williamson@redhat.com, christian.koenig@amd.com,
	kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org
Subject: Re: [PATCH v17 1/4] PCI/DOE: Rename DOE protocol to feature
Message-ID: <20250306185540.GA361668@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306075211.1855177-1-alistair@alistair23.me>

On Thu, Mar 06, 2025 at 05:52:08PM +1000, Alistair Francis wrote:
> DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
> or "Data Object Type".
> 
> PCIe r6.1 (which was published July 24) incorporated that change.
> 
> Rename the existing terms protocol with feature.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

All four patches applied to pci/doe for v6.15, thanks!

  [PATCH v17 1/4] PCI/DOE: Rename DOE protocol to feature
  [PATCH v17 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
  [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
  [PATCH v17 4/4] PCI/DOE: Allow enabling DOE without CXL


