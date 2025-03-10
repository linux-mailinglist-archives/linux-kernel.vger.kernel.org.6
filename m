Return-Path: <linux-kernel+bounces-553675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEFDA58D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830B8188C61F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6692222A0;
	Mon, 10 Mar 2025 07:54:02 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF4E545;
	Mon, 10 Mar 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593241; cv=none; b=QjFPaRCtRrHHbQG3bbAyclJh2L5cz5K12e54k5v8Nijayo2+sgDa2paHmaK3faSlZPRVPyvsHKneA0G4Pr4+J1I6RNSbcwu20gayw9QKkvtlaWEDhgb3cQ56x04kC4Iwpzm+XMo1bCrALKQyk4BEVwjgZTZ8GcE6ZTd3ibik1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593241; c=relaxed/simple;
	bh=UHUBbUuVVoKH0VquUmZL9sgGtO4+cUuhpr1niZO/DL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/XEBIqsXRdm9u/6A8SWbu2MrDOU3KTjoJyl1YAKIpnAW6wvE4cHKyjAylQInIda3mU8VWL3xofoi8r1GiEDVJwTK+18BKax0EEydpvpZhESQqCuy/+LRh6Hh6nXllyRUW/EC2x02BTttvZUu6+STIyQWjBxdp3/drL8u4qfkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 17937140AAD;
	Mon, 10 Mar 2025 06:36:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 148FF1B;
	Mon, 10 Mar 2025 06:36:39 +0000 (UTC)
Message-ID: <8f8c79c5f1c5508defdd4a4c020c2c8e60b95afb.camel@perches.com>
Subject: Re: [PATCH V9 2/2] checkpatch: check format of Vec<String> in
 modules
From: Joe Perches <joe@perches.com>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
 a.hindborg@kernel.org, 	alex.gaynor@gmail.com, aliceryhl@google.com,
 apw@canonical.com, arnd@arndb.de, 	aswinunni01@gmail.com, axboe@kernel.dk,
 benno.lossin@proton.me, 	bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, 	dakr@kernel.org, dwaipayanray1@gmail.com,
 ethan.twardy@gmail.com, 	fujita.tomonori@gmail.com, gary@garyguo.net,
 gregkh@linuxfoundation.org, 	lukas.bulwahn@gmail.com, ojeda@kernel.org,
 pbonzini@redhat.com, tmgross@umich.edu, 	walmeida@microsoft.com,
 charmitro@posteo.net
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 09 Mar 2025 23:36:20 -0700
In-Reply-To: <20250309175712.845622-3-trintaeoitogc@gmail.com>
References: <20250309175712.845622-1-trintaeoitogc@gmail.com>
	 <20250309175712.845622-3-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: p9cph1jeswnj9w9nxbh4c7roihn4nrjs
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 148FF1B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18w88ZBJJCoObOr4Bc2nSFO4NwYZH97oNs=
X-HE-Tag: 1741588599-993698
X-HE-Meta: U2FsdGVkX1+/5wl5cfPQIH0Sr4/zmoFqjKsaQ13RYnEL4VZHhMWRRgf+k+4cRc90b+lUmmpH48H5c7xPf7Rq3EdNbx0hp8Ym6R/9yMaYh+ryKqHt+ZmnWiwG/XCIp9baHMKEmBaxXKk1YbCIN/Dvy1QmbzXIhIIJndC9ky4aQGyNJbZ0CVw7T5FQjY2CxXAs+VgJdkklp1oN1PxFQk7ZlMnmYPlLs0ewlpS72xBnC8RoVNtzonO/fHxoVIGJP5mgGQKKai4SOYGj/vuI2AKRInypatn5mAAtdguToeP8lXGGx9pwF338iT8SsuzlVeRz

On Sun, 2025-03-09 at 14:57 -0300, Guilherme Giacomo Simoes wrote:
> Implement a check to ensure that the author, firmware, and alias fields
> of the module! macro are properly formatted.
>=20
> * If the array contains more than one value, enforce vertical
>   formatting.
> * If the array contains only one value, it may be formatted on a single
>   line

What happens if the patch contains more than one module?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +# check if the field is about author, firmware or alias from module! mac=
ro and find malformed arrays
> +		my $inline =3D 0;
> +		my $key =3D "";
> +		my $add_line =3D $line =3D~ /^\+/;
> +
> +		if ($line =3D~ /\b(authors|alias|firmware)\s*:\s*\[/) {

?

> +		if ($expected_spaces && $spaces) {
> +			if (length($spaces) !=3D length($expected_spaces)) {

spaces contains both spaces and tabs.
Why not test the strings rather than the length?
Otherwise tab-space is the same length as space-tab.

> +				WARN("ARRAY_MODULE_MACRO",
> +					 "Prefer aligned parameters\n" . $herevet_space_add);

Alignment to open parenthesis please.

Why is herevet_space_add more useful than herevet?


