Return-Path: <linux-kernel+bounces-382837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E7A9B13DC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB9A28331E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E068BE7;
	Sat, 26 Oct 2024 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tHvk4J7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F591388
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903486; cv=none; b=LJzpDeY938tGw0lBLVf+Qdrk7DoCUfW2AGmgRjiXfRmw8q1GXhYleeEKFcZTU8tRuZJrXYX1sXto/SuPI+9/g/es+ghifNxqVEwFFcULlE/YztXAVZrQGao7tRYwduqPyO1Oc97SKUiPV6sUJBt44G8icqUsIrLWXvN0jrB1B20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903486; c=relaxed/simple;
	bh=OnyIvgg+0m07TpOJfn2WxKRf7YBafQzs+QMyiNCJcJc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HcIgnHYtBAaxE8A3o5HGqvaOJ0eQ8wjyGdj6ZTLihvO0KK1adFD62wCHH4dE6EJaTxjhONOupOMZlSe3+9q1AQADfVlrrN9dtHCV/ukzb2vmZ3GvSuMEDWfjaJVHKFz1vd9or1LtPoLri5PyabjYvWJrfgyDuBqnsf267QPTp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tHvk4J7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F4FC4CEC3;
	Sat, 26 Oct 2024 00:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729903485;
	bh=OnyIvgg+0m07TpOJfn2WxKRf7YBafQzs+QMyiNCJcJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tHvk4J7uTeNa4aO65BXNHAmLXWc5xxuOqUQM3fjIIchFoKM5mXiV1O/PwoF0lX8yB
	 Eu7hbeUaGb5CHt2wM4srz6Gt/+TFV5m2jiyB2N67vpVuAL/klVrH/d2PSd23b5Q2g7
	 tdHblkgCU4g4MV18iLtOL3lzNlOskSHuOFuo6owo=
Date: Fri, 25 Oct 2024 17:44:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Simon Horman <horms@kernel.org>, Niklas
 =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Philippe Schenker <philippe.schenker@toradex.com>, Louis Peens
 <louis.peens@corigine.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: always parse orig_commit in fixes tag
Message-Id: <20241025174444.7536f7ad4c94fd02afc63077@linux-foundation.org>
In-Reply-To: <20241025-checkpatch-fixes-commit-v2-1-4bc4f06d37b3@gmail.com>
References: <20241025-checkpatch-fixes-commit-v2-1-4bc4f06d37b3@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Oct 2024 19:43:19 -0400 Tamir Duberstein <tamird@gmail.com> wrot=
e:

> Do not require the presence of `$balanced_parens` to get the commit SHA;
> this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
> than a suggestion containing a reference to HEAD.

Got it, thanks.  Below is what I ended up with:


From: Tamir Duberstein <tamird@gmail.com>
Subject: checkpatch: always parse orig_commit in fixes tag
Date: Fri, 25 Oct 2024 19:43:19 -0400

Do not require the presence of `$balanced_parens` to get the commit SHA;
this allows a `Fixes: deadbeef` tag to get a correct suggestion rather
than a suggestion containing a reference to HEAD.

Given this patch:

: From: Tamir Duberstein <tamird@gmail.com>
: Subject: Test patch
: Date: Fri, 25 Oct 2024 19:30:51 -0400
:=20
: This is a test patch.
:=20
: Fixes: bd17e036b495
: Signed-off-by: Tamir Duberstein <tamird@gmail.com>
: --- /dev/null
: +++ b/new-file
: @@ -0,0 +1 @@
: +Test.


Before:

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<titl=
e line>")' - ie: 'Fixes: c10a7d25e68f ("Test patch")'

After:

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<titl=
e line>")' - ie: 'Fixes: bd17e036b495 ("checkpatch: warn for non-standard f=
ixes tag style")'



The prior behavior incorrectly suggested the patch's own SHA and title
line rather than the referenced commit's.  This fixes that.

Ironically this:

Fixes: bd17e036b495 ("checkpatch: warn for non-standard fixes tag style")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Louis Peens <louis.peens@corigine.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/checkpatch.pl |   37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

--- a/scripts/checkpatch.pl~checkpatch-always-parse-orig_commit-in-fixes-tag
+++ a/scripts/checkpatch.pl
@@ -3209,36 +3209,31 @@ sub process {
=20
 # Check Fixes: styles is correct
 		if (!$in_header_lines &&
-		    $line =3D~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i) {
-			my $orig_commit =3D "";
-			my $id =3D "0123456789ab";
-			my $title =3D "commit title";
-			my $tag_case =3D 1;
-			my $tag_space =3D 1;
-			my $id_length =3D 1;
-			my $id_case =3D 1;
+		    $line =3D~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})(?:\s*($ba=
lanced_parens))?/i) {
+			my $tag =3D $1;
+			my $orig_commit =3D $2;
+			my $title;
 			my $title_has_quotes =3D 0;
 			$fixes_tag =3D 1;
-
-			if ($line =3D~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
-				my $tag =3D $1;
-				$orig_commit =3D $2;
-				$title =3D $3;
-
-				$tag_case =3D 0 if $tag eq "Fixes:";
-				$tag_space =3D 0 if ($line =3D~ /^fixes:? [0-9a-f]{5,} ($balanced_pare=
ns)/i);
-
-				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{12}$/i);
-				$id_case =3D 0 if ($orig_commit !~ /[A-F]/);
-
+			if (defined $3) {
 				# Always strip leading/trailing parens then double quotes if existing
-				$title =3D substr($title, 1, -1);
+				$title =3D substr($3, 1, -1);
 				if ($title =3D~ /^".*"$/) {
 					$title =3D substr($title, 1, -1);
 					$title_has_quotes =3D 1;
 				}
+			} else {
+				$title =3D "commit title"
 			}
=20
+
+			my $tag_case =3D not ($tag eq "Fixes:");
+			my $tag_space =3D not ($line =3D~ /^fixes:? [0-9a-f]{5,40} ($balanced_p=
arens)/i);
+
+			my $id_length =3D not ($orig_commit =3D~ /^[0-9a-f]{12}$/i);
+			my $id_case =3D not ($orig_commit !~ /[A-F]/);
+
+			my $id =3D "0123456789ab";
 			my ($cid, $ctitle) =3D git_commit_info($orig_commit, $id,
 							     $title);
=20
_


