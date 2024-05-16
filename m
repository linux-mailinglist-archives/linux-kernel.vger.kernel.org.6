Return-Path: <linux-kernel+bounces-181592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D98C7E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF51B217CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28215820E;
	Thu, 16 May 2024 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E4EZ8KNW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1B1581E7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895142; cv=none; b=lbNwtZDUQCloy8T3BoM0K9SCXtoQEtlzunvlqbG0jLWRpNHpsZtdjW0YgQgaQWbD7p5KFMq+WJjeb1oh9lTbNEIuH0PWJSCw0K/NJ/4RBCToqQ1p73Wifis2x2Vjgb9DAonI8rOfyMFtPaVX/eODCOwnosnDv7loiuypDWQFWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895142; c=relaxed/simple;
	bh=/xyIdp8dCLsFSJJnxRgtGtX4lJOd57hYyh/8O1WvWoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pimhVWb9Pf8/l+F/SjR/0oKA3pk1+d2Xau3FWusuTt0asnbCTx7JJ/a6KpiGCPwBniij6t0lpUkWp/OyyV7DUkt4VBR0GSXd40IXPfLq6dCgH3Dkd+5mqpayM79C4pXCO0eV7faY7OwQuj3reylARmMrgRwWO95VFElx76qP3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E4EZ8KNW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715895138;
	bh=/xyIdp8dCLsFSJJnxRgtGtX4lJOd57hYyh/8O1WvWoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4EZ8KNWafInLO3ZUI2dyXVY50xkdfKAg16BAcfiPBjcT9g7rSKeDgDR2xzJvxnZy
	 1HzjljWsodSiDe7x0L2CP03y3h4k3F8Zxe0oYkAq29W7h3dlnNxIo8Qz+aU8fjpTlY
	 RJvk+T5hJJlNLPbgXOtoZkjJrAYfH5Wybv2cR3BoXyt44vQycW19gN0OdqXzhfiL6s
	 WfjAkKal+52eRqm94AV724076F3sioVkKm3Vkmj5ZNWaY+ZTxX8x8IRpB2Xs0ngShR
	 sqlcgNlV9rmzXBGFHaT3xwHPT6ILUi2uSHK/kCwL5mBMmht4z2NCCVdU4mPY4BKXeu
	 lkVOwXTcXo6yg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1DA5537821AA;
	Thu, 16 May 2024 21:32:17 +0000 (UTC)
Date: Thu, 16 May 2024 17:32:16 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [REGRESSION] boot regression on linux-next on sc7180 platforms -
 null pointer dereference on iommu_dma_sync_sg_for_device
Message-ID: <60f2ec9b-eae2-4ecf-b5fd-3b39c2ebd6cd@notapiano>
References: <6d0da90d-f405-4b5d-b7f9-238cc9405ebe@notapiano>
 <d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano>

On Wed, May 15, 2024 at 05:05:56PM -0400, Nícolas F. R. A. Prado wrote:
> On Tue, May 14, 2024 at 12:41:29PM -0400, Nícolas F. R. A. Prado wrote:
[..]
> Tracked down the issue to commit 8cc3bad9d9d6 ("spi: Remove unneded check for
> orig_nents").
> 
> #regzbot introduced: 8cc3bad9d9d6
[..]

#regzbot monitor: https://lore.kernel.org/all/d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano

