Return-Path: <linux-kernel+bounces-427994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66909E08DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C4B2EB06
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998E192B65;
	Mon,  2 Dec 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="flSSPY+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9FAD51;
	Mon,  2 Dec 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156763; cv=none; b=T3TrCCWOF1DAT/Mxp1ykQ01xqIWnvHGND5HPdLYI+Okg3IZRfMOVYPZ3nr412x8Qmrp0YYGnqKPaENZxtdkixJk7DqNxWlfLc2PjRcFn63cQE8Qo3XDr7QMWCqIdgYukrt8R374FHxV0ygx+1m5Bby225eCcSdCfUerm/eHPyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156763; c=relaxed/simple;
	bh=JWboTPVlDC96tty/L1T44h8tf/BlpOCuVrMa6IirtQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwYjVSdy0Zwyjvq8toLXfqkjP3A2DeR3A3pYf5EtaIjbVwfKAlmBlhB9Iy5pVGB+1Xvk4QZoPiLj/14Fk7IdnjywvohdRlU9ln1apeIiuMyVtM0NspX/lyzCKq5+X9RR+m7zI7ZwdNEeUH5Dt1l3yXTtHTAUcxSdLJ/OHNunZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=flSSPY+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699FBC4CED2;
	Mon,  2 Dec 2024 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733156762;
	bh=JWboTPVlDC96tty/L1T44h8tf/BlpOCuVrMa6IirtQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flSSPY+8D7RlvTkPR/emlLZKwzK0R6q8hD/8p0kWaVeKwv5Bnjya3gRQP/gFSSFw6
	 Evpk53i/mOTEK3c8OVveCrunQXZ7NCkyPUl6UikIl/9STiwfTmUOcbS2f+A5YjUFUf
	 N6wGwSk8iihlRdalI+I5B93FfSHAuI+YGppTjJuk=
Date: Mon, 2 Dec 2024 17:25:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dave Penkler <dpenkler@gmail.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: Fix tnt4882 license to be SPDX compliant
Message-ID: <2024120228-impale-curing-d00b@gregkh>
References: <20241202160404.262993-1-prarit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202160404.262993-1-prarit@redhat.com>

On Mon, Dec 02, 2024 at 11:03:57AM -0500, Prarit Bhargava wrote:
> "GPL-2" is not a valid SPDX license identifier[1].  Update to SPDX
> compliant string "GPL-2.0-only".
> 
> [1] https://spdx.org/licenses

It could also be "GPL-2.0" if you want, but sure, this works.  Note, our
list is older than the current spdx list as we are going off of an older
version for now, until all of the kernel is caught up.

thanks,

greg k-h

