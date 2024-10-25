Return-Path: <linux-kernel+bounces-382602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A69B10F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D521F23765
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D72161F1;
	Fri, 25 Oct 2024 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LapsOP1I"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245B215C7A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889057; cv=none; b=V3LwytySgxeagfsJlovR0cCqZcMZd44NMjWCcCmc5Yojsv/8Lxg7+QAdJP+RsIN+hKLFb5iV1j2fl8OaYWwKcQq6MwOrzwDr3PrHNYBfPcafWTrCRRQic5nE2G05KBTrC0Kt18maw79pcmg97AZoj0zijcR5ycr26vnK/Y+ZCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889057; c=relaxed/simple;
	bh=F8FkPRPDQg4uXqxZUtHVFyWz00ncpUICpOslNv+Bt+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi2t5SFnGODDq/55u2NWot1Nljc+b4YwvhB2Y+ZryLX8xUAPGCPk20Jor7Hz8yNM8aUqisj7jkNjJYHC7dzhieJkRUQL1+k+sUqVCwbeOirsCWSpNlfYjOrfk7XfBWJq+WL6jPISqSTQwIcYln6vGvTLtASt1DlGudikDkmecjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LapsOP1I; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729889052;
	bh=F8FkPRPDQg4uXqxZUtHVFyWz00ncpUICpOslNv+Bt+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LapsOP1IdJMwl3txVj5m0B7qn+x8Ewg8GoC4US2DvdFwea9cnlDg1xSzauHvAcB7o
	 ofnaBkLf8lyPo6fz7udgduN2r04iE5N+r4sXNKg3JHXN7dZpID23b0q9pWHFqHRb5l
	 5K2Xoh/CeOEwoosHm1pWXTslkOFUKtnMz3BtRpE5x2xWRY8kitUJ/qF9/7dGn3MFk4
	 16AKFazzg2TrxFu0ToBOTH2ePu8YUMlhdFL8hKXeqE9GV9glTzynKtlTcvSedO+TCU
	 curmo1cShj/JzNDtf+2UHJyV6YDu75jobFgYVQ4ir6GEXsnD7qGdvpYdY7xvmaP0gX
	 pUz5JcokIQeFA==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E28F17E375C;
	Fri, 25 Oct 2024 22:44:10 +0200 (CEST)
Date: Fri, 25 Oct 2024 16:44:08 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: dan.carpenter@linaro.org, anders.roxell@linaro.org,
	ben.copeland@linaro.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
	rafael@kernel.org
Subject: Re: [RFC] driver core: add a dbg printk for successful probes
Message-ID: <559c1719-f45b-48ab-93ba-b4a103d84980@notapiano>
References: <dc7af563-530d-4e1f-bcbb-90bcfc2fe11a@stanley.mountain>
 <20241025125834.19758-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025125834.19758-1-laura.nao@collabora.com>

On Fri, Oct 25, 2024 at 02:58:34PM +0200, Laura Nao wrote:
> Hi Dan,
> 
> On 10/24/24 16:54, Dan Carpenter wrote:
> > Hi Laura, and Nicolas,
> > 
> > I've been thinking about the driver probing talk you gave last year.  The
> > talk was about how tricky it is sometimes to determine which drivers have
> > probed successfully.  The drivers might be built into the kernel instead of
> > as a module, for example.  The idea was that we could make a list of
> > drivers we expected to probe successfully and find regressions in probe
> > that way.
> > 
> > Why couldn't we just add a printk in call_driver_probe() and then we could
> > pass
> > 
> > 	dd.dyndbg="func call_driver_probe +p"
> > 
> > at the kernel command line.
> >
> 
> Thanks for highlighting this.
> 
> This could be useful for debugging by making sysfs information more
> accessible and easier to parse, though it may not add significant value for
> automated testing.
> 
> The main challenge with these tests is building a list of devices expected
> to be probed on a given platform, rather than knowing if a certain driver
> was probed. From our experience with KernelCI and bootrr[1], manually
> creating and maintaining such lists can become a high-maintenance task.
> Relying on kernel output with the suggested debug prints as a reference
> file would still require significant upkeep - generating, storing, and
> updating the reference for each platform over time. Additionally, there's a
> risk that some failures could go undetected, if for example a driver is
> missing from the kernel config at the time the reference is created or
> updated.
> 
> Our approach with the DT[2] and ACPI[3] kselftests has been to avoid using
> external reference files where possible and instead rely on stable
> information already within the kernel. We use the device tree or ACPI
> tables as sources to identify which devices are present, then scrape sysfs
> to verify whether they’ve been successfully probed. Of course, this
> approach isn’t always feasible - some information isn’t exposed by the
> kernel, such as devices on discoverable buses, and reference files may be
> necessary to cover these cases.

And just to give more information on this note, to test the devices that aren't
covered by DT or ACPI:
* We've introduced the Discoverable Devices[4] kselftest, which targets devices
  on USB and PCI buses and requires describing those devices in a reference file
  beforehand;
* And more recently we've been proposing the Device Existence[5] kselftest that
  just needs to be run once to generate a reference automatically and has the
  broadest coverage, detecting all devices on the system, although in its
  current state it does not check for driver probe, only device presence.

We've also added a short documentation page[6] comparing those tests and a
couple others.

Since for these devices the need for a reference is unavoidable, the aim of the
tests is to try to encode the system information in the most stable way possible
to reduce maintenance and false-positives.

Thanks,
Nícolas

[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/devices/probe
[5] https://lore.kernel.org/all/20240928-kselftest-dev-exist-v2-1-fab07de6b80b@collabora.com/
[6] https://lore.kernel.org/all/20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com

