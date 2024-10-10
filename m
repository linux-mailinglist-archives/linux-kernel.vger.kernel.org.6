Return-Path: <linux-kernel+bounces-358602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B307D99817B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B2E1F2107D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626211C4610;
	Thu, 10 Oct 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="EN1gPGQw"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45D1C460E;
	Thu, 10 Oct 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550838; cv=pass; b=DlehU526Auxd+FEh66a9Vq9WLAOuGgFl8E2XUAep0WHMm+4oJw0LD+7Nc93ipyRE9YmhYSokBJFxIo3iAllu9bXSjrfYTotnTbfASTdJyldpCbZPwdQLeyUWM64khAhpVdUZaV7Eh9O+3/L3bySRE7xg7n3pWXQ6EfZzI4mN6Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550838; c=relaxed/simple;
	bh=F2/xlZumL78V5SPlw2OT8WU3WdRU7v3xKxHpUft8vKc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FrJcx6UPHtOnyrs/VUZX2TUUz7dptcVqmqCiA7e+uc/2SX8WCkkFhx1dAcXjufwjnUeQ4FFTKBvfK6d3yhGJRCwhqF205cQKH2BJlPGGH1HVudqvwlcZ5kGdvGudGCaJzhffDtnIJ7Gx8/BBkI+g+gbgMvGm+gcPjV3ATqanSPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=EN1gPGQw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728550800; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZY/7NabpGRbM/WYwGTn08wMZp5q7tPQYfqW22geI0dKB70d04ZWB83077dd5hWJ755WgEg4DxFWC+Rua/KGokZCYj9JaTLY8a+I9ajvbJGYIGdtyjDwchMwt+MnSTkva1eH53wIVPYhZ+c0SIKBaTD+3TqKmjPoZNY2Ow9+SjSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728550800; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y46skrOzK3VnYpAd88NWud4+XfH2Sps4zrKUa3K8zx0=; 
	b=PtYtlBs1RX3Ubk4a3yF+FwHuoOBwmONJ67+PtQsn9/HhBkbQaMGnysZ5R/nSZTldON6Orx6wyiSIdtL9VwNcybSsoFC524hIMbpR2bidJ8Th5qan1+PhEagv81mJW/ZIRzP33hy5tB2rYkMEmwN7A3pQ2OHidJXi6uGGmYUJuAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728550800;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=y46skrOzK3VnYpAd88NWud4+XfH2Sps4zrKUa3K8zx0=;
	b=EN1gPGQwyXO4a/O7aChrCP2OuIAc44jYrzhXHnloAufWGX2aNQSNfSNUgIpjAPhA
	WADxcJ6fGTAF1Q97lQxqyG9uqxx1Kn1QdXj1lbiWkc93Ea5gOwlOmMvvMHFeIR1tVH1
	GLkFYn74z39qTkhNoQkci8Qk7i9gtL//B8gRh9Dg=
Received: by mx.zohomail.com with SMTPS id 1728550797942445.0697997890277;
	Thu, 10 Oct 2024 01:59:57 -0700 (PDT)
Message-ID: <50784fc0-6f30-4a12-8452-3e0d43cc1c14@collabora.com>
Date: Thu, 10 Oct 2024 13:59:46 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241008115702.214071228@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/8/24 5:00 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 25 passed, 0 failed

    Boot tests: 510 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: dd3578144a91f9258e2da8e085a412adc667dba5
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

