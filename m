Return-Path: <linux-kernel+bounces-372645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65559A4B67
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 07:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401FC1C21AAD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F801D7E4E;
	Sat, 19 Oct 2024 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="AKGPua7U"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352F1CCB38;
	Sat, 19 Oct 2024 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729317047; cv=none; b=mjr/g5OMaX5ICav/VMVvEPaubBDTe3DttKTh5IcrtP29vrAaD1mZ0Z2zuQ6aakABzj+flJSsUd/nBYFhVhz5YJCbdK45b0zGYECOPtRK9f55igsAPu3V0Eygxq9W7Qv7b/ic2ZfM1cWswyCBbKCCJ+ywXuMSEGQQuMc2oWmvgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729317047; c=relaxed/simple;
	bh=Yd4Fs47R95Xhl+hYjNiRRFQTEKOFnFFuNP4IpGSs/9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbjswK6UyXHSwbQR1JVJw1ThaAwiUS6jDXdUsEEyA0Hv53DvHLx6AnT0KVGzeTGUUN+cK5x2JpeMwPJ/u80NMOQC1zGc8DWApI7s81IEFhUI32viptc4v/KldmnHPY9tNzVSyVUt8FkAkr4oSicHq0/5/oYITVmNTNPBMM3G+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=AKGPua7U; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 8528C1770FF; Sat, 19 Oct 2024 05:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729317044; bh=Yd4Fs47R95Xhl+hYjNiRRFQTEKOFnFFuNP4IpGSs/9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKGPua7Ua3Z1OwV2WqvPaj5TCQzptroNZ+Am+q/Z1eZTg1Qjrv66We+AzeoEDrstf
	 gGJ806uyhfohoKzjT6hsMzxz+Z4xyr5HA+7YgpoldDD2Aexy/ey4sH01A885lPb3ag
	 dO4jwfjFRIyKy5mtgkG7/r6512hOjRXzDQ2kVCxwg2e/zg8Z58fKYtp6Q5LTJxYqfk
	 FiGxoMqGZ8N/KyfrHPBwHTazANdFmqmy+ygVyIdyffIfi5MtiHoHC1XBnZrtCx4Qr3
	 lNa6F/q6M3nE7mBh33/NvAfYHY3dsSOnVCYiTrTA3memr25UQ84+t5yQI0o5a2WtXb
	 3ZebGvYfXTNXg==
Date: Sat, 19 Oct 2024 05:50:44 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	dianders@chromium.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: English fixes in kgdb/kdb article
Message-ID: <20241019055044.GA803351@lichtman.org>
References: <20241018163136.GA795979@lichtman.org>
 <20241018175540.GA796909@lichtman.org>
 <20241018223536.GA799515@lichtman.org>
 <87wmi5vwgh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmi5vwgh.fsf@trenco.lwn.net>

On Fri, Oct 18, 2024 at 05:10:38PM -0600, Jonathan Corbet wrote:
> A couple of comments..
> 
> Nir Lichtman <nir@lichtman.org> writes:
> 
> > Minor grammar and typos fixed in the kgdb/kdb article
> >
> > Signed-off-by: Nir Lichtman <nir@lichtman.org>
> > ---
> 
> When you post followup versions to a patch, please put an explanation in
> this space saying what has changed; that makes life easier for
> reviewers. 
> 
> >  Documentation/dev-tools/kgdb.rst | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> Beyond that, it is good to wait a little while before posting new
> versions to let other reviews come through.  Three iterations in one day
> are a bit much.
> 
> That said, the patch looks OK now; I'll apply it shortly.
> 
> Thanks,
> 
> jon

Noted, thanks

