Return-Path: <linux-kernel+bounces-317486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C772C96DF00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DA01F23F56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB719DFB4;
	Thu,  5 Sep 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OGIs3/nf"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCE39FC5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551848; cv=none; b=hW7AJ/Y2GuppICEXIs37D835Q8FIMQES3wjcAucy9JtT3RDg7r0ui8br98BU2Da3HgaxV/jhhlf0nbirqawMeLP6nPYiz6wpYiUFeDGeTAbY6be/elgHNDpdiv6sAOD7uLD9C3OXrr3+qk8UOvpaQQhvhWM+um2OzEBmKXNi8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551848; c=relaxed/simple;
	bh=dzmgB04Y1V6xRQ37bcHxi9Bcf35Xbz42lSlqS3FVzPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+g+yQDr1EnP5b8OyQwk7AStwX6+SjpPvQh4ozi0uUj1J0N9BNmkQNhJePtwwGEOLWCUfbKH1KFsNYiQ3uaZpZFYNO9E9pCD8N/csQR64MEecNhudFc7bzoYY1KALOXT4RC+wznjmI5TSeQF2R+mpIwGDt4EYbF2ADFbvZUW9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OGIs3/nf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725551842;
	bh=dzmgB04Y1V6xRQ37bcHxi9Bcf35Xbz42lSlqS3FVzPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGIs3/nfT/sxEt/h1TusJVDdFu/H3edxfUR385+vJyVc0vMpuZZ5feJwefI10U691
	 3THZZKpB82FfZ/Zb6nusbHnjjmbNblMWG+ZLBi94UjLDOrBJGnv1fsMjaO7QWrAMhn
	 GOs/Nrm4uoHXKvz2bYwHibrz/53xMGMR5iXE+070=
Date: Thu, 5 Sep 2024 17:57:22 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
Message-ID: <bcdba244-aaf9-4a06-a4a6-c521d4cfa97e@t-8ch.de>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
 <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de>
 <ZtlOGkADy7OkXY9u@1wt.eu>
 <ZtlQbpgpn9OQOPyI@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtlQbpgpn9OQOPyI@1wt.eu>

On 2024-09-05 08:32:14+0000, Willy Tarreau wrote:
> On Thu, Sep 05, 2024 at 08:22:18AM +0200, Willy Tarreau wrote:
> > > 
> > > ./run-tests.sh -p -m user
> > > 
> > > These toolchains can then also be used for direct "make" invocations
> > > through CROSS_COMPILE.
> > 
> > I really suspect an empty CC variable somewhere that could explain why
> > only CROSS_COMPILE is used. I'll try to find time today to give it a
> > try here as well, just in case I can reproduce the same issue.
> 
> In fact I'm getting it without any options:
> 
>   $ ./run-tests.sh
>   realpath: /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory
> 
> It comes from here in test_arch():
> 
>         cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
> 
> Thus it's indeed related to the absence of the toolchain there. It's
> just that the way the error is reported (due to set -e) is a bit harsh.

Ack. It should not occur with "-p" though.

> What about this ?
> 
>   $ ./run-tests.sh 
>   No toolchain found in /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux.
>   Did you install the toolchains or set the correct arch ? Rerun with -h for help.
>   Aborting...
> 
> or anything similar, achieved by this patch (warning copy-paste, mangled
> indents):
> 
> diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
> index e7ecda4ae796..0f67e80051dc 100755
> --- a/tools/testing/selftests/nolibc/run-tests.sh
> +++ b/tools/testing/selftests/nolibc/run-tests.sh
> @@ -143,6 +143,13 @@ test_arch() {
>         arch=$1
>         ct_arch=$(crosstool_arch "$arch")
>         ct_abi=$(crosstool_abi "$1")
> +
> +       if [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
> +               echo "No toolchain found in ${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}."
> +               echo "Did you install the toolchains or set the correct arch ? Rerun with -h for help."
> +               return 1
> +       fi
> +
>         cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
>         build_dir="${build_location}/${arch}"
>         if [ "$werror" -ne 0 ]; then

Looks good.

