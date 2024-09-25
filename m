Return-Path: <linux-kernel+bounces-338354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1629856C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286591F25430
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB1A156C73;
	Wed, 25 Sep 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKsdi0CB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA006F2F2
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258334; cv=none; b=HAISMr8V8eUYaDU7X/+0WcS4bs35De6WjcIro33TXQYv1llAh3VQ9MgyCbZRK79wyz2p0zypcw/yHzmVIPXOTCVwW5uqsUbSha6DDF7MFBTnPnIvgdvI1b54p3h0JYWfMKSIx3mNLicArIlo2HS1X/A33dCsWEkUAComALeZSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258334; c=relaxed/simple;
	bh=nV4dHiwCNbF4w4hNhx3h6iwt/QSxODoaBS1QeY/71/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uafEl6FIp53pjYDMKtlUJqlr3IGT/zf0lLUwwvv+SCnH915RBTxeuH+RYsNvFMPJ/9m1LYoZrVhmhb5GZ7hYqy+EH+yEkgyVDFbVbcaiAkZsvf7CgUucrLwd0aqB4JrZG2OPPFxq+1KpLC64/CuDkYcmDzpzaFbYpK1zScz21HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKsdi0CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6C1C4CEC3;
	Wed, 25 Sep 2024 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727258334;
	bh=nV4dHiwCNbF4w4hNhx3h6iwt/QSxODoaBS1QeY/71/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKsdi0CBkSSx59G7uM0w5EilS/ZdA4OgdIDNcg8G0D8T7glhjhpxWTmrlDraeLVfV
	 2KFMLHMuX0bnmrw0Nxp0vtqV8yeZEybDyy07doWkdOiRhDpZhIaiSNT6HxgaFbRXue
	 LrhG/lG1mR0r1cE2mPtmFNyIXbRxTQQo6m1Bl6EvP2qpLVDAy/m1YmJdNxmZ5SiBOY
	 Xuv6oGQQJ/4mL4bo2CpcJBri+cJVhUJbyrc+72K1rUQxl5YfGU2vCtGHTFRvoXqqAr
	 WmwRAgCqypDOEGAbL05AtCSVpKReYWomT7KEZ4JztDxpR/nIizRdRiSNRWQhxkvC7g
	 +bD2pQNPFZUGA==
Date: Wed, 25 Sep 2024 10:58:50 +0100
From: Lee Jones <lee@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: da9052-spi: change read-mask to write-mask
Message-ID: <20240925095850.GE7545@google.com>
References: <20240918-da9052-v1-1-ce7e7024e48c@gmail.com>
 <Zuvmaq9-BddwM2Pc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zuvmaq9-BddwM2Pc@gmail.com>

On Thu, 19 Sep 2024, Marcus Folkesson wrote:

> On Wed, Sep 18, 2024 at 11:12:22AM +0200, Marcus Folkesson wrote:
> > Actually, the LSB bit is set on write rather than read.
> > Change it to avoid nasty things to happen.
> > 
> Fixes: e9e9d3973594 ("mfd: da9052: Avoid setting read_flag_mask for da9052-i2c driver")

Please resubmit the patch.

> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

-- 
Lee Jones [李琼斯]

