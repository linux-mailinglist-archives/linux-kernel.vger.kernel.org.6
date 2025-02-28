Return-Path: <linux-kernel+bounces-538405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9DCA49837
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6953B306E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E75261585;
	Fri, 28 Feb 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="7TvzsY9C"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173E25DD0F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741573; cv=none; b=AWb1nQBJKEFLaDv3cwe7gx8+xRLkuiwGMmQJC8bFuZP2LffPo/4BapaOhpEXoX9HFOjxmDDPxcsfiBIW1Y4Kn4fY5JadqMUbtu02umFusy0tGh0XTK2js3dhN3dJuPYOH3nepCWYle+vQI03640zA7gHRo7zz+Zra51JNBUAT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741573; c=relaxed/simple;
	bh=eUncUDixM5FyLQhw8vDqPNpSrZ0shJG7fl0bOhNxBQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTmH52nEp/xYv56/7p+dYMcfOtBveDqRqjkZZcQZ0M/oSLTbmgzdjvHhiRRDt8xb5voq5yb5IHC79ul3rzjlb9g2M8D4t3KcUT7oS1f7LX2DvUJeLg5IqJFpx9pastqL84NfNQd46qmBZpjVq1quPeaRbVmGKNjlmO1vNyRWQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=7TvzsY9C; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 70C2243F38;
	Fri, 28 Feb 2025 12:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740741570;
	bh=eUncUDixM5FyLQhw8vDqPNpSrZ0shJG7fl0bOhNxBQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=7TvzsY9Ch/JkQeQzeAeJdV4lYTvZbtMa3fMlYZGVaBjRP+vBJ0jRZgz2o4hvuToBW
	 fJ06NcOeiH3evCRKyDd4bBbNIEWQlmNu5OmBO99ZQvEOlVyFAQDKZGOxvC00142qSE
	 IxwCAT9TArmDzgqDFGmi/dtsiE7rxCPklvPy3LYcJaIsd8KdKF1zfLWPEeiFTItTjs
	 C62Ji8iSX0bRopJRgcoH9wN4bAZru6lUwo+3YD3f8/m6I5wG8uQzBwQ+2CXLFtsXDe
	 jw5wVAq3eejfzMWo76JlFfwswofz6MHCeGFwOO+sAPXHEySAL9ee4LGEqVSHkqrZtm
	 BrLpqcTzlmqww==
Date: Fri, 28 Feb 2025 12:19:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] [PULL REQUEST] iommu/vt-d: Fixes for v6.14-rc5
Message-ID: <Z8GbwVmxd9ooFTT6@8bytes.org>
References: <20250228102726.3429268-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228102726.3429268-1-baolu.lu@linux.intel.com>

On Fri, Feb 28, 2025 at 06:27:24PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following fixes have been queued for v6.14-rc:
> 
> - Fix suspicious RCU usage splat
> - Fix passthrough for devices under PCIe-PCI bridge
> 
> They have been reviewed and tested. Can you please take them?
> 
> Best regards,
> baolu
> 
> Jerry Snitselaar (1):
>   iommu/vt-d: Remove device comparison in context_setup_pass_through_cb
> 
> Lu Baolu (1):
>   iommu/vt-d: Fix suspicious RCU usage
> 
>  drivers/iommu/intel/dmar.c  |  1 +
>  drivers/iommu/intel/iommu.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)

Applied, thanks Baolu.

