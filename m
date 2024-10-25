Return-Path: <linux-kernel+bounces-381714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF69B033F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C395B220FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DD2064FF;
	Fri, 25 Oct 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="Q0XGpri9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F22064F1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861107; cv=pass; b=KIbz0QiGRfvoxMkjCb5YIPYibP+pQo4WnymvOpQEoghNGBmEyu63jOjsrHhLD1m56+PvHH1Uw29R+F/pytf/iQZYpI/pSwm0Je9C8h1MCBLr3kBLwudp5hhvSXXv6CNrULJkrzYRJtRDdSPWOdznQUReMUT91BqYu4qpwij+DZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861107; c=relaxed/simple;
	bh=bSqgphrSQd+StoauxLgYYy8+3gS+9qbioFhQR0qLFjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwMe4OOLYiKlsPJP8w8wNfHo5gNIzn+M7HqPcAqXk4YEAtp9rg0MHmtIj3/wh44qzfDPk39i6+bJlURwYcPHeBhxSeAz+Y7fraDFvEQJ1x03Vc6lmpmGjIaT5NrxrTkcz2rKwUghskn/4KyZ5CjEPReYsKUjFeEdDdUqJP2CrJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=Q0XGpri9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729861099; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dTjt74f4YuEQue4r6+asUnWySX4muDG7uFAegJPdKW0lkLXvAHFDPpwfW2miSE8d+r7MKh2pVfbWZCLAfKdLR/nFKSHYsAYLHL3FC6K4GTqUvWvIyMKEf8Z7jjyI4XBTtWKkq1mPN/0fyHH67QrjduJJ08jX+01kfHM2RayDHi4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729861099; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GDCKLoH0Q57kwp9YXTlUUKDeNjZNXQ0LJEZJx0f4XrQ=; 
	b=REG40WbEPcMrt+qMahre8cER2iIjyfrg/Y6h4PhCsvu466pDCSkw7RJp+w9cm3ultsnHp7jClsVDv8QlwmIoh4yR3WUAfI+juB3/AhVMTGXQkIgZJNrRCd/CV+FFJKbWaW9Z350C725tsb5Ai7PccKg640pF3GBhhVegNfZ0HW4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729861099;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=GDCKLoH0Q57kwp9YXTlUUKDeNjZNXQ0LJEZJx0f4XrQ=;
	b=Q0XGpri9qptzPzOBTSDAwBy6qoVf1tu+YCo/J595E0WuIqKI52fZbJtgFau/r6nK
	NWBhdSt3s4tVjhFFtbj2+K/YCAoxiXZfv9kXuSQ1Lh1A+KLGXKU24THGuTbEgp1nFKm
	d8j/b5wh4p2Mz84gYaQ9/50qXFflLqF/0RHRQ3xc=
Received: by mx.zohomail.com with SMTPS id 1729861096774100.16335330811296;
	Fri, 25 Oct 2024 05:58:16 -0700 (PDT)
From: Laura Nao <laura.nao@collabora.com>
To: dan.carpenter@linaro.org
Cc: anders.roxell@linaro.org,
	ben.copeland@linaro.org,
	gregkh@linuxfoundation.org,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	nfraprado@collabora.com,
	rafael@kernel.org
Subject: Re: [RFC] driver core: add a dbg printk for successful probes
Date: Fri, 25 Oct 2024 14:58:34 +0200
Message-Id: <20241025125834.19758-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <dc7af563-530d-4e1f-bcbb-90bcfc2fe11a@stanley.mountain>
References: <dc7af563-530d-4e1f-bcbb-90bcfc2fe11a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Dan,

On 10/24/24 16:54, Dan Carpenter wrote:
> Hi Laura, and Nicolas,
> 
> I've been thinking about the driver probing talk you gave last year.  The
> talk was about how tricky it is sometimes to determine which drivers have
> probed successfully.  The drivers might be built into the kernel instead of
> as a module, for example.  The idea was that we could make a list of
> drivers we expected to probe successfully and find regressions in probe
> that way.
> 
> Why couldn't we just add a printk in call_driver_probe() and then we could
> pass
> 
> 	dd.dyndbg="func call_driver_probe +p"
> 
> at the kernel command line.
>

Thanks for highlighting this.

This could be useful for debugging by making sysfs information more
accessible and easier to parse, though it may not add significant value for
automated testing.

The main challenge with these tests is building a list of devices expected
to be probed on a given platform, rather than knowing if a certain driver
was probed. From our experience with KernelCI and bootrr[1], manually
creating and maintaining such lists can become a high-maintenance task.
Relying on kernel output with the suggested debug prints as a reference
file would still require significant upkeep - generating, storing, and
updating the reference for each platform over time. Additionally, there's a
risk that some failures could go undetected, if for example a driver is
missing from the kernel config at the time the reference is created or
updated.

Our approach with the DT[2] and ACPI[3] kselftests has been to avoid using
external reference files where possible and instead rely on stable
information already within the kernel. We use the device tree or ACPI
tables as sources to identify which devices are present, then scrape sysfs
to verify whether they’ve been successfully probed. Of course, this
approach isn’t always feasible - some information isn’t exposed by the
kernel, such as devices on discoverable buses, and reference files may be
necessary to cover these cases.

I think debug prints could improve readability but won’t fundamentally
simplify automated testing. What would truly make a difference is if the
kernel could expose expected devices and their corresponding drivers in a
standardized, stable way - ideally in a dedicated place in sysfs (as
suggested in the RFCv1 of the ACPI kselftest). This would make automated
testing easier by reducing the need to parse scattered directories in sysfs
and avoid workarounds to handle exceptions, like skipping devices that
don't have drivers or managing devices represented in sysfs through
multiple directories. For example, in the ACPI kselftest, the main
challenge was determining which devices should have a driver folder in
sysfs and which shouldn’t. So far, I haven’t found a straightforward way to
expose this information in a structured format in sysfs though.

Any thoughts or ideas on this are welcome!

Best,

Laura

[1] https://github.com/kernelci/bootrr
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/dt
[3] https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@collabora.com/
 
> On my qemu system the `dmesg | grep succeeded` looks like this:
> 
> [    0.135501] reg-dummy reg-dummy: probing reg-dummy succeeded
> [    0.169490] psci-cpuidle-domain psci: probing psci-cpuidle-domain succeeded
> [    0.188039] ctrl 9000000.pl011:0: probing ctrl succeeded
> [    0.188598] port 9000000.pl011:0.0: probing port succeeded
> [    0.206720] uart-pl011 9000000.pl011: probing uart-pl011 succeeded
> [    1.071943] pl061_gpio 9030000.pl061: probing pl061_gpio succeeded
> [    1.117740] pci-host-generic 4010000000.pcie: probing pci-host-generic succeeded
> [    1.159963] virtio-mmio a003e00.virtio_mmio: probing virtio-mmio succeeded
> [    1.166752] virtio-pci 0000:00:01.0: probing virtio-pci succeeded
> [    1.168180] virtio-pci 0000:00:02.0: probing virtio-pci succeeded
> [    1.173959] virtio-pci 0000:00:03.0: probing virtio-pci succeeded
> [    1.178934] ctrl serial8250:0: probing ctrl succeeded
> [    1.179059] port serial8250:0.0: probing port succeeded
> [    1.182032] port serial8250:0.1: probing port succeeded
> [    1.182490] port serial8250:0.2: probing port succeeded
> [    1.182916] port serial8250:0.3: probing port succeeded
> [    1.183309] port serial8250:0.4: probing port succeeded
> [    1.183705] port serial8250:0.5: probing port succeeded
> [    1.185558] port serial8250:0.6: probing port succeeded
> [    1.185962] port serial8250:0.7: probing port succeeded
> [    1.186352] port serial8250:0.8: probing port succeeded
> [    1.189519] port serial8250:0.9: probing port succeeded
> [    1.189972] port serial8250:0.10: probing port succeeded
> [    1.190378] port serial8250:0.11: probing port succeeded
> [    1.190791] port serial8250:0.12: probing port succeeded
> [    1.191180] port serial8250:0.13: probing port succeeded
> [    1.191595] port serial8250:0.14: probing port succeeded
> [    1.192017] port serial8250:0.15: probing port succeeded
> [    1.193533] port serial8250:0.16: probing port succeeded
> [    1.193955] port serial8250:0.17: probing port succeeded
> [    1.194360] port serial8250:0.18: probing port succeeded
> [    1.197551] port serial8250:0.19: probing port succeeded
> [    1.197965] port serial8250:0.20: probing port succeeded
> [    1.198353] port serial8250:0.21: probing port succeeded
> [    1.201960] port serial8250:0.22: probing port succeeded
> [    1.202528] port serial8250:0.23: probing port succeeded
> [    1.202997] port serial8250:0.24: probing port succeeded
> [    1.203415] port serial8250:0.25: probing port succeeded
> [    1.203819] port serial8250:0.26: probing port succeeded
> [    1.204279] port serial8250:0.27: probing port succeeded
> [    1.204669] port serial8250:0.28: probing port succeeded
> [    1.205659] port serial8250:0.29: probing port succeeded
> [    1.209673] port serial8250:0.30: probing port succeeded
> [    1.210117] port serial8250:0.31: probing port succeeded
> [    1.210643] serial8250 serial8250: probing serial8250 succeeded
> [    1.212911] kgdboc kgdboc: probing kgdboc succeeded
> [    1.291410] virtio_blk virtio0: probing virtio_blk succeeded
> [    1.309485] virtio_blk virtio3: probing virtio_blk succeeded
> [    1.331200] virtio_net virtio1: probing virtio_net succeeded
> [    1.354786] fw_cfg 9020000.fw-cfg: probing fw_cfg succeeded
> [    1.356688] scmi_virtio_transport firmware:scmi-vio-backend: probing scmi_virtio_transport succeeded
> [    1.357830] scmi-virtio virtio2: probing scmi-virtio succeeded
> [    1.394738] scmi-clocks scmi_dev.3: probing scmi-clocks succeeded
> [    1.415087] arm-scmi arm-scmi.0.auto: probing arm-scmi succeeded
> [    1.426512] armv8-pmu pmu: probing armv8-pmu succeeded
> 
> I kind of wish all the printks in that function started with __func__.  Would
> this be useful for you?  Send me any feedback you have and I can resend this as
> a proper patch.
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9b745ba54de1..e8cc710ead76 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -579,6 +579,7 @@ static int call_driver_probe(struct device *dev, const struct device_driver *drv
>   
>   	switch (ret) {
>   	case 0:
> +		dev_dbg(dev, "probing %s succeeded\n", drv->name);
>   		break;
>   	case -EPROBE_DEFER:
>   		/* Driver requested deferred probing */
> 


