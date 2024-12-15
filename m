Return-Path: <linux-kernel+bounces-446428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766D9F2439
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE937A1018
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A248218C903;
	Sun, 15 Dec 2024 13:42:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC220322
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734270172; cv=none; b=jJv0EH12DnRxtSfiWbiybto7m3ZB5WRGNBEj/QKPy5eKSzkSYCvSwgRRoR2q/KNKxa2VDZiZRmR5V0qUqaFqA8ds/bJ0HVhU9fXRpxZif09uZKST0CCSJw7gqDGMmIVAZ9yZgTDMUhVTTWGD0vRMfa95MfHVaoQ8OT7Sr/JGiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734270172; c=relaxed/simple;
	bh=7h+5+TtthdhuATeTnSGeU3tWKDrE69lXaz8BDEhsa+s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QsZuuVLhtWyfriBHQqRAK7d6QDw3j2/sQZ8iikwNESkNqWB8H8PUcFosnZAOdFt4yMy44T3nehpnjiM4nqrN288mcIczYUdyW/D51uQlsS4rjKOXLYHu/41ugCK6tX/5Pxq2tTBVtNzqFskGlqqXP544fB83oz3MWk1A6hufLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id F1862B2595;
	Sun, 15 Dec 2024 13:42:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id C0DDF1A;
	Sun, 15 Dec 2024 13:42:19 +0000 (UTC)
Message-ID: <be6ab9045b893b25bd0cb27e100bd5905fdc9281.camel@perches.com>
Subject: Re: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
From: Joe Perches <joe@perches.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Simon
 Horman <horms@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Colin Ian King	 <colin.i.king@gmail.com>, Yu Jiaoliang
 <yujiaoliang@vivo.com>, WangYuli	 <wangyuli@uniontech.com>,
 linux-kernel@vger.kernel.org, Andy Whitcroft	 <apw@canonical.com>
Date: Sun, 15 Dec 2024 05:42:45 -0800
In-Reply-To: <59832da1-34a6-42be-ba85-e86d05b9d29b@canonical.com>
References: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
	 <031e2929d88843c2fa913ed7f3ee2abbe041a68a.camel@perches.com>
	 <59832da1-34a6-42be-ba85-e86d05b9d29b@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C0DDF1A
X-Stat-Signature: faibogg4hjhsyawsax6t9to3aauk9dxw
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/2KLGcwz9gMgcdC8bZolL1aw+7HbOevW8=
X-HE-Tag: 1734270139-808726
X-HE-Meta: U2FsdGVkX18w+KItWHuE0A9c+6tZxUf4lShAhF9sz4BND4+mGSYSkxhpBPsYXDIF/6CGzM+12eyksWfn45bkXqAK6rcepIQejdkw/uVABsbnGGNipNE0Cu7s4oOFjR2H2B+42zwGFKeGIZPFN6nFY/j32GK40BQhaVcDgeKEP/RrwZ5GF1HQ1nKap0kobQUzamrXCqYhvnyfNZIDSGvHU/unXT+SqCkXGM1r2MZU1jfSHMW0PU5bTqKtruan8gtSaCM0AIc6+yyi0nZzNZNL6+hmrTfx33YksSGNdemjvGn1zbR2ggh2BGlauN07Vma8OxQtQlrmBiTjHuy3ZCmSmrnWPhh7IPS3rorng3HOvRoGbt3/5pXy8Q==

On Sun, 2024-12-15 at 13:41 +0100, Heinrich Schuchardt wrote:
> On 12/15/24 11:51, Joe Perches wrote:
> > On Sun, 2024-12-15 at 03:51 +0100, Heinrich Schuchardt wrote:
> > > The correct SPDX identifier for the 'GNU General Public License v2.0 =
or
> > > later' is GPL-2.0-or-later.
> >=20
> > I think this unnecessary as there's a separate script
> > to check the appropriate SPDX uses treewide and there
> > isn't a single existing use of "gpl-2.0+' in the tree.
>=20
> Hello Joe,
>=20
> In next-20241213 I find 5143 occurrences with
>=20
> git grep -ni 'gpl-2\.0+' | wc -l

So no uses of 'gpl-2.0+' but many of 'GPL-2.0+'

And perhaps read this:

https://lore.kernel.org/all/CAHk-=3Dwi2bdXuYhC9bd9FShtcf_u-6RUb3Qr_aXq3XtbC=
xR5NGQ@mail.gmail.com/

