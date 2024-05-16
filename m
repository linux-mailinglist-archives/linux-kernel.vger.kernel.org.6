Return-Path: <linux-kernel+bounces-181195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1A8C78DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C884C281C07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458814B97C;
	Thu, 16 May 2024 15:02:25 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8A514B969
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871745; cv=none; b=q1ko0fMcIjTpo+hH6IHtK2bBE71+6a4JaPm1oS8XMFQWwEwdT51QCsbRuc4qWdY2MRsEbacvChcasin4QsucfVKtNcN76pnGZa14rHnFA8OHA7FLvpPfD7JRXlDnrxLF3NoNv75t+G9Ahs7+iKrrmr+obL0VZ5RAbQ0h6o7iEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871745; c=relaxed/simple;
	bh=gXoWBoXtXBpNI3VqUpla1J72BNbCAzZhjk4toEodcyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=saQ/3R+3q6Qd2Ttpxz13SBTgJR6P5nGGGCl09Mr6BYNzcchez1ARpKUkuCJIo9+GGt/lCmYNEx4sb3EEh9roWrXV6iibIAupzZ9S3f54llrSdY1qEPjlVaKEGDtXF8OfKitrgcIE1xUdW4L16hV8LoVDUgxNdxbaNzYMCyRV6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id ADD26140402;
	Thu, 16 May 2024 14:43:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 57ECF20024;
	Thu, 16 May 2024 14:43:19 +0000 (UTC)
Message-ID: <4a77b3a77db293acba504914af220d8b8d644616.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: allow multi-statement declarative
 macros.
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org, Andy Whitcroft <apw@canonical.com>, Dwaipayan
 Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 16 May 2024 07:43:18 -0700
In-Reply-To: <20240516141418.25345-1-jim.cromie@gmail.com>
References: <20240516141418.25345-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: mju6c8wbgf6gfb8fgnwn6yu59ximhujy
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 57ECF20024
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+R8Vbk930gfY1y8+k6ZBXumRqXreZfIMw=
X-HE-Tag: 1715870599-267049
X-HE-Meta: U2FsdGVkX1/lzKfoZz+Vev/LZzjDmrVIIyqZEWkbWagL8BFFPHTu99DfYkPD4Yh36GbTWVPtnQdXK4xTzx/eIiV/353Rsygr0SUxRbpIKW4QqsWSVMKLFR4TDwdtOoBNVKNsBf0t+yrHr+W8R1ox5yaI2bpzLJsy7YWsd6q/eQnplrQh1y1RYWO/bk3UHoNbT9yzIWXTb1/7MfRe30VtM8Cgr2A33BjACX97lfwJ+Jam746oIFlhHBlSp5EZn5qWWAFHffN+TkphdmrJNGW3wr2mdW10sEU367lLZbbYtfHTojIzeVfDFwGfThX8wkj1

On Thu, 2024-05-16 at 08:14 -0600, Jim Cromie wrote:
> Declarative macros, which declare/define storage (at either file or
> function scope), cannot be wrapped in do-while statements.  So
> checkpatch advice is incorrect here.
>=20
> The code has an $exceptions regex which allows multiple statements
> based on the macro name, etc; /DECLARE_PER_CPU|DEFINE_PER_CPU/ are
> currently accepted, widen those to accept /DECLARE|DEFINE/.

It seems this exempts too large a number of these macros

$ git grep -P '^\s*\#\s*define\s+\w*(?:DECLARE|DEFINE)\w*'|wc -l
5075

How about somehow limiting these exemptions more strictly?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5901,6 +5901,7 @@ sub process {
>  			}
>  		}
> =20
> +# except for declarative macros (whether file or function scope),
>  # multi-statement macros should be enclosed in a do while loop, grab the
>  # first statement and ensure its the whole macro if its not enclosed
>  # in a known good container
> @@ -5958,8 +5959,8 @@ sub process {
>  				$Declare|
>  				module_param_named|
>  				MODULE_PARM_DESC|
> -				DECLARE_PER_CPU|
> -				DEFINE_PER_CPU|
> +				DECLARE|
> +				DEFINE|
>  				__typeof__\(|
>  				union|
>  				struct|


