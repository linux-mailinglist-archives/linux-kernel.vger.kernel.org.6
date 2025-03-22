Return-Path: <linux-kernel+bounces-572429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D87A6CA44
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB8188C8E9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE64C221F2D;
	Sat, 22 Mar 2025 13:23:15 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432B1DF26B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649795; cv=none; b=j+BU5HbE65Zi1HOsGntADEtV2dJXwxCBXnbeEFDNLLJeYP7sQe6JOZ84ICfb6ohpaoLSXbXceJ/kszv4Dlwfh5gIe8lBvrFk25vkhGc1Ad49AFp6xpqTEqockYFNcjIg+bZt8sDIBlU1kMhVCE4XZqCsemV0/j6X04mZvpld6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649795; c=relaxed/simple;
	bh=GNWhqIPtbxtPCtd8D13F1J71Bey1g0P410ONxS5nW54=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhq8BW/GKXC0n1Saa3iATZMFlX1J4fkTaoq7R2R4lZhFHddafsLMFMMpFEVVqyZLG2GzFQvDKddDv+3uOjTX3cZlJZEoI3UMXh0OgAL1ydSi1tFZx6BzaZjt3V3eJjQ9W4k3VRJ27l4NbHrEGg/wSNhmNjTe0OE+e1MgOtSmlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id c7ad57d1-0720-11f0-95fc-005056bdd08f;
	Sat, 22 Mar 2025 15:23:04 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Mar 2025 15:23:01 +0200
To: Andi Shyti <andi.shyti@kernel.org>
Cc: sven@svenpeter.dev, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/4] i2c: pasemi: Add registers bits and switch to BIT()
Message-ID: <Z965tVhC5jxy1kqZ@surfacebook.localdomain>
References: <20250222-pasemi-fixes-v1-0-d7ea33d50c5e@svenpeter.dev>
 <20250222-pasemi-fixes-v1-1-d7ea33d50c5e@svenpeter.dev>
 <rjvak3c2k5a64jw4ef23i5uptg4zzl3u7lqszqbg56l4hqms77@hrkn5eydxwiy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjvak3c2k5a64jw4ef23i5uptg4zzl3u7lqszqbg56l4hqms77@hrkn5eydxwiy>

Thu, Mar 20, 2025 at 01:23:25AM +0100, Andi Shyti kirjoitti:
> Hi Sven,
> 
> On Sat, Feb 22, 2025 at 01:38:33PM +0000, Sven Peter via B4 Relay wrote:
> > From: Sven Peter <sven@svenpeter.dev>
> > 
> > Add the missing register bits to the defines and also switch
> > those to use the BIT macro which is much more readable than
> > using hardcoded masks
> > 
> > Co-developed-by: Hector Martin <marcan@marcan.st>
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> 
> Just this patch merged to i2c/i2c-host.

This needs an update as well. The proper header for BIT() et al. is bits.h.
bitfield.h is for FIELD_*() et al.

-- 
With Best Regards,
Andy Shevchenko



