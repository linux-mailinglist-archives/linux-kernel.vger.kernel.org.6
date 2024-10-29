Return-Path: <linux-kernel+bounces-386247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4F9B40F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B392A2839B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308421E00B4;
	Tue, 29 Oct 2024 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kx1TrdSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC57FC0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171892; cv=none; b=pt8pjf8+d7ehZSaTXdeP5lJwEXkwNslHIV9fARWbX7VRgN/Mbnekwy2VjQarPJl3sx3o2E4e5fv8TxH1Mw9doDE87IcCpvH9yPXd0wFs4QgTr0VkCGfth/CD5jCXhLh5NtTgaHEZ5h53maTiARuVfrG38D3qbvzh8VY5+TgT9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171892; c=relaxed/simple;
	bh=09v15yyCBOFMI6JleIGqkpIoxG3wjbCI5gVlVGW47Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1Wq4u7fMHUa7hRHAL4hegj3VIAdeHqtlDUBu2O080JfE0NHoDCzIf5jm8kCcuKUSTBQ1U+QFz+CzykZPVryrIjS2czs9d5mPYK74AI0wvv2LxMVLHEgcuoDlF8C8sF3oYfLzCm2UnBp/PDJsGLXJRG3errBhBa96nD0ekJM0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kx1TrdSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DB2C4CECD;
	Tue, 29 Oct 2024 03:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730171892;
	bh=09v15yyCBOFMI6JleIGqkpIoxG3wjbCI5gVlVGW47Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kx1TrdSssXIxSXb2I/gpWcYafqt1xofFk96gnaItYBJkVk2nmeklG7rbwlzyHkrZI
	 Wfsq9PSuyHlNYaDQGkUDlckQuANn33UaHmIIP4ym3klb7fI+XmDlbH+DnKTw8K7qsd
	 EpIgBnMBAL8rFve5QSM3sEzLPHrFwALf2W784MXk=
Date: Tue, 29 Oct 2024 04:17:58 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI changes for v6.13-rc1
Message-ID: <2024102950-pectin-embassy-6c8d@gregkh>
References: <bb5eaca8dc2ea5b8e900efbccd53b3d991da753d.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5eaca8dc2ea5b8e900efbccd53b3d991da753d.camel@intel.com>

On Fri, Oct 25, 2024 at 10:54:13AM +0000, Winiarska, Iwona wrote:
> Hi Greg!
> 
> Please pull PECI update for Linux v6.13.
> 
> Thanks
> -Iwona
> 
> The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:
> 
>   Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git tags/peci-next-6.13-rc1

Pulled and pushed out, thanks.

greg k-h

