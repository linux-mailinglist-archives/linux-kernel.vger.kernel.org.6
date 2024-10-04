Return-Path: <linux-kernel+bounces-349936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2A98FD91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AF52839AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A2132117;
	Fri,  4 Oct 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ogo6CnLo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2A26281;
	Fri,  4 Oct 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024907; cv=none; b=HL4qnaaNRO4vucftSzaOrxaDxXzkJZ949UEETGYOG0lWrda6B2s6PFg4Zm2d3ZtkjjEVX6CoZtPY5rd7NkuGdp+nzoqGWo98z4SXlUV0xK4c5a0lp6GNyAMYHWUGrjA2r5NWv+4nduBXL5qjRRZfgbLK8FZ6P7p3fxyxifQrAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024907; c=relaxed/simple;
	bh=/Yb+m7ZHMFf8uynm9lEz2NY1ZaPP/bRn5yc46Bjkz3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjWaziShhawDALw737qs4XUN+aAPOMNe+Npyo/QGTpMsoIIC0NqjICRfoOhXMapJygxSLrPvO2I0NL6yypVAB3APsalp80RKLVbdPWDrZM4q842B8HZQZ1/MsnIzFUGSpnzbgZzD+B33VDVQcrQZDQamNAs35W4yRp+HZ5KasSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ogo6CnLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF05C4CECC;
	Fri,  4 Oct 2024 06:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728024907;
	bh=/Yb+m7ZHMFf8uynm9lEz2NY1ZaPP/bRn5yc46Bjkz3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ogo6CnLoyQcYa5xyWWZonzvPKQwMa3zpsa97/+WfZbECgoYbT/Iv7+5SsORHLyLXy
	 PRy84kFf2inGQ3nVlaQnrjA8IJxDwzv8ByXz7uZFMjUPYE8bgbldwyADXtb25ixDNK
	 S8gpNjoYSvDuLaEx06TBrYruQ6kQQfIo/L6j/KIQ=
Date: Fri, 4 Oct 2024 08:55:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
Message-ID: <2024100426-wheat-heavily-68d1@gregkh>
References: <20241003103209.857606770@linuxfoundation.org>
 <20241004071723.69AD.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004071723.69AD.409509F4@e16-tech.com>

On Fri, Oct 04, 2024 at 07:17:24AM +0800, Wang Yugui wrote:
> Hi,
> 
> > This is the start of the stable review cycle for the 6.6.54 release.
> > There are 533 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> 
> A new waring is report by 'make bzImage' in 6.6.54-rc2, 
> but that is not reported in 6.6.53 and 6.12-rc1.
> 
> arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> arch/x86/tools/insn_decoder_test: warning: ffffffff8103c4d5:    c4 03 81 48 cf e9       vpermil2ps $0x9,%xmm15,%xmm14,%xmm15,%xmm9
> arch/x86/tools/insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 0
> arch/x86/tools/insn_decoder_test: warning: Decoded and checked 6968668 instructions with 1 failures
> 
> the root cause is yet not clear.

I've been seeing this locally for all 6.6.y releases, so for me it isn't
new, and I can't seem to track down the root cause.  As it's just now
showing up for you, can you do a 'git bisect' to find out the issue?

thanks,

greg k-h

