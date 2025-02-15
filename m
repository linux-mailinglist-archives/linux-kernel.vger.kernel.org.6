Return-Path: <linux-kernel+bounces-516023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1082A36C20
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91389169BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB118D634;
	Sat, 15 Feb 2025 05:24:14 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79C2F4A;
	Sat, 15 Feb 2025 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739597053; cv=none; b=kRTRntj3PdNIj8Pr5k+uz9kLHSMY9CA93TgR0Neei9utY/wbGufIoMK/rPGv3PoufPA+Zu0bzs/6YbPTN/K9s+h2pIlatKdmwG8gI3SOpRSMvL/cr54R13FySfuAY3KT7TJ+zYgb03vjGFTwedqvn537aYacNDJxlu0g77Mahnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739597053; c=relaxed/simple;
	bh=jP4NIklTRbCXV9xg2OGCxfTC+MVzTgnFZB316UaFaSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plxLOX4RhH2S0oIysJMsauM4nukRvF+6qp99dLKvcE6i2jqUMJenVSN0uHiEFH5agbhQDM4FoLO2K3L/OkF2MGDtK6eWl8PV5J/Monvh1N6zArfobEygxhNFUNJzGgxBkcSXvkCS8Gshw5BWS23BMffhRMvWrYTPt6cXCsdiOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4EDC881396;
	Sat, 15 Feb 2025 05:24:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id D25B42F;
	Sat, 15 Feb 2025 05:24:02 +0000 (UTC)
Message-ID: <4e7d00e8e39e5394c601e2a69038e6349b7b91e7.camel@perches.com>
Subject: Re: [PATCH V2 2/2] checkpatch: throw error in malformed arrays
From: Joe Perches <joe@perches.com>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
 a.hindborg@kernel.org, 	alex.gaynor@gmail.com, aliceryhl@google.com,
 apw@canonical.com, arnd@arndb.de, 	aswinunni01@gmail.com, axboe@kernel.dk,
 benno.lossin@proton.me, 	bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, 	dakr@kernel.org, dwaipayanray1@gmail.com,
 ethan.twardy@gmail.com, 	fujita.tomonori@gmail.com, gary@garyguo.net,
 gregkh@linuxfoundation.org, 	lukas.bulwahn@gmail.com, ojeda@kernel.org,
 pbonzini@redhat.com, tmgross@umich.edu, 	walmeida@microsoft.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 21:24:01 -0800
In-Reply-To: <20250214184550.120775-3-trintaeoitogc@gmail.com>
References: <20250214184550.120775-1-trintaeoitogc@gmail.com>
	 <20250214184550.120775-3-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D25B42F
X-Stat-Signature: w3qmsemnecanh5kj57hwnpaf1x9p5med
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19M5YyYpGUVLUubuQf7JMw1puyiDOyM1q4=
X-HE-Tag: 1739597042-618923
X-HE-Meta: U2FsdGVkX199gBYHxdBQyrUxC4brFpX3PQB6h+vX2Bc/F/KNLTpWgSnTsNnYbbDuK01Hch2M3xJN0mEDw4ijBvTgIaNkdKmIzlqCvvUpM8pqw7x5In4ITtC1uSbnRqsk9oVf+yi1zgQ/UyWebHYQ0QCCJePWRiHDxS4YbLFcAwqq8OYNRf939JYjnUsN3kqH/rG60EVDVnzMXs6PwZb9keiagDaUYInXmhAf+kMCKlwoZPIWUMG1hFvQYGQ8vT1Q4mJzLOt8C7rF3Ta6hW0VhrHtkZTuGCNeOdWGXVC2k615HKUaCytio8Y1GR67GdY7YbsETuoUtqjj9z2AOQv8eMvr9O0Wcjco

On Fri, 2025-02-14 at 15:45 -0300, Guilherme Giacomo Simoes wrote:
> In module! macro, some fields have a string array type, and we need a
> check for guarantee a good formatation.
> Check if the current line contains one of these keys that must be a
> string array and if so, make a regex for check if contains more than one
> value in array, if yes, the array should be in vertical. If array have
> only one value, so the array can be in the same line.
>=20
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3567,6 +3570,46 @@ sub process {
[]
> +
> +		if ($add_line && $key) {
> +			my $herevet =3D "\n$here\n" . cat_vet($rawline) . "\n";

Please look at the other checkpatch uses of $herevet=20
$herevet does not begin with '\n'

> +
> +			my $counter =3D () =3D $line =3D~ /"/g;
> +			my $more_than_one =3D $counter > 2;
> +			if ($more_than_one) {
> +				WARN("ARRAY_MODULE_MACRO",
> +						"Prefere one value per line$herevet");

Prefer not Prefere
Align to open parenthesis
So this should be
				WARN("ARRAY_MODULE_MACRO"
				     "Prefer one value per line\n" . $herevet);

etc...


