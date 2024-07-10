Return-Path: <linux-kernel+bounces-247663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849D592D2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77351C21D64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85722192495;
	Wed, 10 Jul 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+I04Zyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960731DDC5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618031; cv=none; b=EvI3sXbMdG4+qfCLLZFOJS1UIsOAHzjJBEENs1aInKDEXBGr/RJC730CgIQkxUPojxR3PNhBGbkb7L0U5NEu2jj9Hvi/OaXiE8iGxGy/5AW1VG3m4+Y9HNLsodw2T8qKHiiTXD0cyyqQT5JvCyWBb0zxlXmsZKoO93EwzfGUdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618031; c=relaxed/simple;
	bh=UNsXxnrRStkdEmctUxdgHywps83zZJ/TlY0S14ZRfQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXKZll1Nr+5zmHiBbT+6b4WSw3Db0DEjsOirmuyliY7eN9f2equvCEcd4XmBih+MEUyPPWwoM7RMnf9fjAFQOoptVOgEKoWArFrAUlj+wUKBoxnYP5k1Gh+8z038WU+oRcoo7fJdTAGHjbtBbFhC0SFeQIIxI1ExjsCNf9FYdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+I04Zyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6212C32781;
	Wed, 10 Jul 2024 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720618031;
	bh=UNsXxnrRStkdEmctUxdgHywps83zZJ/TlY0S14ZRfQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+I04Zyv6/oseALRLTcXVX55eL5COjUGfws+ReRKLdg2y2CRfUmCajgPNRr1P3R2o
	 ivOIFfzVi87DqucGFnoXqZ12cZjwfU8VSYU8kT4OEUz0X6s0zlS4JzUL0jEtRUAmkW
	 nWqPKTRWszgnxa2Y35TJeSoi82KOAG7G0cxYLZA0=
Date: Wed, 10 Jul 2024 15:27:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Message-ID: <2024071053-mahogany-cavalier-6692@gregkh>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
 <2024071026-squirt-trustful-5845@gregkh>
 <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>

On Wed, Jul 10, 2024 at 01:19:56PM +0000, Vamsi Krishna Attunuru wrote:
> 
> 
> >-----Original Message-----
> >From: Greg KH <gregkh@linuxfoundation.org>
> >Sent: Wednesday, July 10, 2024 6:28 PM
> >To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> >Cc: arnd@arndb.de; Jerin Jacob <jerinj@marvell.com>; Srujana Challa
> ><schalla@marvell.com>; linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
> >CN10K DPI administrative driver
> >
> >On Sat, Jul 06, 2024 at 08: 30: 09AM -0700, Vamsi Attunuru wrote: > Adds a
> >misc driver for Marvell CN10K DPI(DMA Engine) device's physical > function
> >which initializes DPI DMA hardware's global configuration and > enables
> >hardware mailbox 
> >On Sat, Jul 06, 2024 at 08:30:09AM -0700, Vamsi Attunuru wrote:
> >> Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> >> function which initializes DPI DMA hardware's global configuration and
> >> enables hardware mailbox channels between physical function (PF) and
> >> it's virtual functions (VF). VF device drivers (User space drivers)
> >> use this hw mailbox to communicate any required device configuration
> >> on it's respective VF device. Accordingly, this DPI PF driver
> >> provisions the VF device resources.
> >>
> >> At the hardware level, the DPI physical function (PF) acts as a
> >> management interface to setup the VF device resources, VF devices are
> >> only provisioned to handle or control the actual DMA Engine's data transfer
> >capabilities.
> >>
> >> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> >> Reviewed-by: Srujana Challa <schalla@marvell.com>
> >> ---
> >> Changes V9 -> V10
> >> - Added checks to ensure reserved fields are set to 0
> >>
> >> Changes V8 -> V9:
> >> - Addressed minor comments
> >>
> >> Changes V7 -> V8:
> >> - Used bit shift operations to access mbox msg fields
> >> - Removed bitfields in mailbox msg structure
> >>
> >> Changes V6 -> V7:
> >> - Updated documentation with required references
> >> - Addressed V6 review comments
> >>
> >> Changes V5 -> V6:
> >> - Updated documentation
> >> - Fixed data types in uapi file
> >>
> >> Changes V4 -> V5:
> >> - Fixed license and data types in uapi file
> >>
> >> Changes V3 -> V4:
> >> - Moved ioctl definations to .h file
> >> - Fixed structure alignements which are passed in ioctl
> >>
> >> Changes V2 -> V3:
> >> - Added ioctl operation to the fops
> >> - Used managed version of kzalloc & request_irq
> >> - Addressed miscellaneous comments
> >>
> >> Changes V1 -> V2:
> >> - Fixed return values and busy-wait loops
> >> - Merged .h file into .c file
> >> - Fixed directory structure
> >> - Removed module params
> >> - Registered the device as misc device
> >>
> >>  Documentation/misc-devices/index.rst          |   1 +
> >>  Documentation/misc-devices/mrvl_cn10k_dpi.rst |  52 ++
> >>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >>  MAINTAINERS                                   |   5 +
> >>  drivers/misc/Kconfig                          |  14 +
> >>  drivers/misc/Makefile                         |   1 +
> >>  drivers/misc/mrvl_cn10k_dpi.c                 | 676 ++++++++++++++++++
> >>  include/uapi/misc/mrvl_cn10k_dpi.h            |  39 +
> >>  8 files changed, 789 insertions(+)
> >>
> >> diff --git a/Documentation/misc-devices/index.rst
> >> b/Documentation/misc-devices/index.rst
> >> index 2d0ce9138588..8c5b226d8313 100644
> >> --- a/Documentation/misc-devices/index.rst
> >> +++ b/Documentation/misc-devices/index.rst
> >> @@ -21,6 +21,7 @@ fit into other categories.
> >>     isl29003
> >>     lis3lv02d
> >>     max6875
> >> +   mrvl_cn10k_dpi
> >>     oxsemi-tornado
> >>     pci-endpoint-test
> >>     spear-pcie-gadget
> >> diff --git a/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> >> b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> >> new file mode 100644
> >> index 000000000000..a75e372723d8
> >> --- /dev/null
> >> +++ b/Documentation/misc-devices/mrvl_cn10k_dpi.rst
> >> @@ -0,0 +1,52 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +===============================================
> >> +Marvell CN10K DMA packet interface (DPI) driver
> >> +===============================================
> >> +
> >> +Overview
> >> +========
> >> +
> >> +DPI is a DMA packet interface hardware block in Marvell's CN10K silicon.
> >> +DPI hardware comprises a physical function (PF), its virtual
> >> +functions, mailbox logic, and a set of DMA engines & DMA command
> >queues.
> >> +
> >> +DPI PF function is an administrative function which services the
> >> +mailbox requests from its VF functions and provisions DMA engine
> >> +resources to it's VF functions.
> >> +
> >> +mrvl_cn10k_dpi.ko misc driver loads on DPI PF device and services the
> >> +mailbox commands submitted by the VF devices and accordingly
> >> +initializes the DMA engines and VF device's DMA command queues. Also,
> >> +driver creates /dev/mrvl-cn10k-dpi node to set DMA engine and PEM
> >> +(PCIe interface) port attributes like fifo length, molr, mps & mrrs.
> >> +
> >> +DPI PF driver is just an administrative driver to setup its VF
> >> +device's queues and provisions the hardware resources, it cannot
> >> +initiate any DMA operations. Only VF devices are provisioned with DMA
> >capabilities.
> >> +
> >> +Driver location
> >> +===============
> >> +
> >> +drivers/misc/mrvl_cn10k_dpi.c
> >> +
> >> +Driver IOCTLs
> >> +=============
> >> +
> >> +:c:macro::`DPI_MPS_MRRS_CFG`
> >> +ioctl that sets max payload size & max read request size parameters
> >> +of a pem port to which DMA engines are wired.
> >> +
> >> +
> >> +:c:macro::`DPI_ENGINE_CFG`
> >> +ioctl that sets DMA engine's fifo sizes & max outstanding load
> >> +request thresholds.
> >> +
> >> +User space code example
> >> +=======================
> >> +
> >> +DPI VF devices are probed and accessed from user space applications
> >> +using vfio-pci driver. Below is a sample dpi dma application to
> >> +demonstrate on how applications use mailbox and ioctl services from DPI
> >PF kernel driver.
> >> +
> >> +https://urldefense.proofpoint.com/v2/url?u=https-
> >3A__github.com_Marve
> >> +llEmbeddedProcessors_dpi-2Dsample-
> >2Dapp&d=DwIBAg&c=nKjWec2b6R0mOyPaz7
> >>
> >+xtfQ&r=WllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m=bFx_7eltw7S
> >6zzVu
> >>
> >+1LNEdtsbwwynJfAKTja649QUwGNU_y4uWqGoEZ4f7JluYLjX&s=wOMzADbq
> >9f4xxz1Oug
> >> +-slj_xy4ZcbrnWfQJWeO0_ugA&e=
> >> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> index a141e8e65c5d..def539770439 100644
> >> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> @@ -362,6 +362,7 @@ Code  Seq#    Include File
> >Comments
> >>  0xB6  all    linux/fpga-dfl.h
> >>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-
> >remoteproc@vger.kernel.org>
> >>  0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin
> ><avagin@openvz.org>>
> >> +0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Marvell CN10K DPI
> >driver
> >>  0xC0  00-0F  linux/usb/iowarrior.h
> >>  0xCA  00-0F  uapi/misc/cxl.h
> >>  0xCA  10-2F  uapi/misc/ocxl.h
> >> diff --git a/MAINTAINERS b/MAINTAINERS index
> >> aae88b7a6c32..2c17d651954a 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -13477,6 +13477,11 @@ S:	Supported
> >>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> >>  F:	drivers/mmc/host/sdhci-xenon*
> >>
> >> +MARVELL OCTEON CN10K DPI DRIVER
> >> +M:	Vamsi Attunuru <vattunuru@marvell.com>
> >> +S:	Supported
> >> +F:	drivers/misc/mrvl_cn10k_dpi.c
> >> +
> >>  MATROX FRAMEBUFFER DRIVER
> >>  L:	linux-fbdev@vger.kernel.org
> >>  S:	Orphan
> >> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> >> faf983680040..965641017a62 100644
> >> --- a/drivers/misc/Kconfig
> >> +++ b/drivers/misc/Kconfig
> >> @@ -585,6 +585,20 @@ config NSM
> >>  	  To compile this driver as a module, choose M here.
> >>  	  The module will be called nsm.
> >>
> >> +config MARVELL_CN10K_DPI
> >> +	tristate "Octeon CN10K DPI driver"
> >> +	depends on ARM64 && PCI
> >
> >Why does ARM64 matter here?  I don't see any dependency required of it.
> >
> Thanks, Greg, for your time. This DPI device is an on-chip PCIe device and only present on
> Marvell's CN10K platforms(which are 64-bit ARM SoC processors), so added those dependency.

Then perhaps keep the ARM64 and add a COMPILE_TEST option as well so
that we can build this as part of normal testing?

So that would be:
	depends on PCI && (ARM64 || COMPILE_TEST)
right?

thanks,

greg k-h

