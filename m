Return-Path: <linux-kernel+bounces-446351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911219F233E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA11D165720
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79F154449;
	Sun, 15 Dec 2024 10:59:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3513C9D9
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260392; cv=none; b=WLPpJRtWriqsGfXVVfCArbHNrLslWw3oHsYGgXeBNkD6OQnZJOd+cFf2AAI5HJOzkBG21tlolmjuCqYESWyqWgt3+DG7Z8KQld2r36lDig0DNAeu+RAVq0D9aJGT/fqUJcYqwUpGZKizToU0+h0koKZWT3dGquDaswCZq1ewVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260392; c=relaxed/simple;
	bh=a/unxMjSmQonzQaothVkHwWJRYcFHhbgg77V/Vn3o9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kteb1DvkX5eSpc4fexTN7QB/NMYabPOTLYcEPiLgryNzHzg5RB+mmRrGUbqstfmZCTkRAsf7UEMR3M7Dx8ElI/VOJA/7rW2RIxBKdL43clgLSQiPQjWr3aAR3Mk0uPZtzKaRO04LRz2/sMh/vciXENQ6osB6DnPTbvG4quv5k6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id CFC621CABFA;
	Sun, 15 Dec 2024 10:51:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 8504533;
	Sun, 15 Dec 2024 10:50:35 +0000 (UTC)
Message-ID: <031e2929d88843c2fa913ed7f3ee2abbe041a68a.camel@perches.com>
Subject: Re: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
From: Joe Perches <joe@perches.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Andy Whitcroft
	 <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Simon
 Horman <horms@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Colin Ian King	 <colin.i.king@gmail.com>, Yu Jiaoliang
 <yujiaoliang@vivo.com>, WangYuli	 <wangyuli@uniontech.com>,
 linux-kernel@vger.kernel.org
Date: Sun, 15 Dec 2024 02:51:03 -0800
In-Reply-To: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
References: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: ntp3m4nm9cdap11esq1xae4m1finpqre
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8504533
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/DZGa+0AWSneN1NYid7v/1JXfrMC8KeaI=
X-HE-Tag: 1734259835-283606
X-HE-Meta: U2FsdGVkX194s04+1Z/mhMpGxZ7wtfzRYn3OFulmORnYBu1FAZOHjW8W0MyuVmMwE+iOcmGTes7NPsarvwJV896nz6ngMNbUGpRihzeZ128mUPNDq/GohCQqaNEWI+JxpYqaZCpeQxb2XR1g220w37BuuIOvtIn0nHPJ9xCBIavXOJhgLQ8gGCIHRTRq4gbt8uDgv7omW60FRX3PqtvPulAkb1XUM40vhxZefgTcylRIkWijR18jUv73d3LTRsMkEYxALKW/ESl9GXavPBr0/qn6eyftqcgNyd9cm2R/RjGazhK6x9rh+RfVfXcv32fE

On Sun, 2024-12-15 at 03:51 +0100, Heinrich Schuchardt wrote:
> The correct SPDX identifier for the 'GNU General Public License v2.0 or
> later' is GPL-2.0-or-later.

I think this unnecessary as there's a separate script
to check the appropriate SPDX uses treewide and there
isn't a single existing use of "gpl-2.0+' in the tree.


>=20
> Checkpatch.pl uses the misspelled words from spelling.txt both as keys of=
 a
> hash and as part of a regular expression. For usage in the regular
> expression special characters like the plus sign need to be escaped.
>=20
> Heinrich Schuchardt (2):
>   checkpatch: allow special characters in spelling.txt
>   scripts/spelling.txt: add GPL-2.0+
>=20
>  scripts/checkpatch.pl | 2 +-
>  scripts/spelling.txt  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20


