Return-Path: <linux-kernel+bounces-425219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C789DBF09
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12292164995
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C015532A;
	Fri, 29 Nov 2024 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LY/cc8DG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21992914;
	Fri, 29 Nov 2024 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854444; cv=none; b=O5T6+ID0uyI17s+9V9lQTyl6pk/Q4EMtvt2TFM9G2jMB3U0tJCFG1Zw0s9bKm09/3QVYo1wf8OuUNUfgtTT2FmXIIELWpY4NrCSSyUbOeoTkdHJ/d7d1JUix/7usYEJuZGiIP3UiHjowgqRt9QD9L78KHjvRRfwqtbeY07Mkw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854444; c=relaxed/simple;
	bh=xn+IGm5Os/dxqyXTpM3NCDmTqLmxBPo48n214H5q7HA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VAlCzcSnK3c/Go9H1kL9uglJFPUuYliX6bGBrFNOnaNwM0utFNcYQ7ZbTle+KmMwHK7u9YF3yD047nI6CfpXcX9jb2dw+qw+Ruh0ivlNUWzF/kbc+S0IaWvty09lklORPO8Hxz30Mvcm+vEjVwOCduuA2Z/y80WeAFSujw6Jh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LY/cc8DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5D0C4CECF;
	Fri, 29 Nov 2024 04:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732854443;
	bh=xn+IGm5Os/dxqyXTpM3NCDmTqLmxBPo48n214H5q7HA=;
	h=Date:From:To:Cc:Subject:From;
	b=LY/cc8DGrHcEq05Mw02eoMWXRfL43i4Ei/zdc+4oBty5RLvX8GzR5XIKqF1HSin9m
	 t00QuHJZWBaODtoStngeFbwwH3GtDGUVZpr8kdQcgIPI5el0ynpAd8jHNlAq1RgZu4
	 En+XMlVlHSQ7Hcgxx/OKeaiE2MN+Xpv9xvukbqoM=
Date: Fri, 29 Nov 2024 05:27:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt changes for 6.13-rc1
Message-ID: <Z0lCp08uUj3Jx5o3@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.13-rc1

for you to fetch changes up to 237d4e0f41130a5ff0e1c7dc1cb41ee2fe21cd2a:

  usb: typec: tcpm: Add support for sink-bc12-completion-time-ms DT property (2024-11-16 09:05:44 +0100)

----------------------------------------------------------------
USB / Thunderbolt (USB4) changes for 6.13-rc1

Here is the big set of USB and Thunderbolt changes for 6.13-rc1.

Overall, a pretty slow development cycle, the majority of the work going
into the debugfs interface for the thunderbolt (i.e. USB4) code, to help
with debugging the myrad ways that hardware vendors get their interfaces
messed up.  Other than that, here's the highlights:
  - thunderbolt changes and additions to debugfs interfaces
  - lots of device tree updates for new and old hardware
  - UVC configfs gadget updates and new apis for features
  - xhci driver updates and fixes
  - dwc3 driver updates and fixes
  - typec driver updates and fixes
  - lots of other small updates and fixes, full details in the shortlog

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aapo Vienamo (8):
      thunderbolt: Don't hardcode margining capabilities size
      thunderbolt: debugfs: Add USB4 Gen 4 margining capabilities
      thunderbolt: debugfs: Implement Gen 4 margining eye selection
      thunderbolt: debugfs: Replace "both lanes" with "all lanes"
      thunderbolt: debugfs: Replace margining lane numbers with an enum
      thunderbolt: debugfs: Refactor hardware margining result parsing
      thunderbolt: debugfs: Don't hardcode margining results size
      thunderbolt: debugfs: Implement asymmetric lane margining

Abdul Rahim (1):
      usb: gadget: f_midi: prefer strscpy() over strcpy()

Abhishek Tamboli (1):
      usb: gadget: uvc: Remove extra semicolon from the macro

Akash Kumar (2):
      usb: gadget: uvc: configfs: Add frame-based frame format support
      usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs

Amit Sunil Dhamne (5):
      dt-bindings: connector: Add properties to define time values
      usb: typec: tcpm: Add support for parsing time dt properties
      dt-bindings: connector: Add time property for Sink BC12 detection completion
      dt-bindings: usb: maxim,max33359: add usage of sink bc12 time property
      usb: typec: tcpm: Add support for sink-bc12-completion-time-ms DT property

Andre Przywara (2):
      dt-bindings: usb: sunxi-musb: add Allwinner A523 compatible string
      dt-bindings: usb: add A523 compatible string for EHCI and OCHI

Andy Shevchenko (5):
      usb: typec: stusb160x: Make use of i2c_get_match_data()
      USB: bcma: Remove unused of_gpio.h
      xhci: pci: Use standard pattern for device IDs
      xhci: pci: Fix indentation in the PCI device ID definitions
      usb: cdns3: Synchronise PCI IDs via common data base

Charles Han (2):
      phy: realtek: usb: fix NULL deref in rtk_usb2phy_probe
      phy: realtek: usb: fix NULL deref in rtk_usb3phy_probe

Colin Ian King (1):
      usb: gadget: function: remove redundant else statement

Dan Carpenter (1):
      usb: typec: fix potential array underflow in ucsi_ccg_sync_control()

Dingyan Li (2):
      usb: storage: use US_BULK_FLAG_OUT instead of constant values
      usb: storage: fix wrong comments for struct bulk_cb_wrap

Dmitry Baryshkov (3):
      dt-bindings: usb: qcom,dwc3: Add SAR2130P compatible
      usb: typec: ucsi: glink: fix off-by-one in connector_status
      usb: typec: ucsi: glink: be more precise on orientation-aware ports

Edward Adam Davis (1):
      USB: chaoskey: Fix possible deadlock chaoskey_list_lock

Frank Wang (1):
      dt-bindings: usb: add rk3576 compatible to rockchip,dwc3

Geert Uytterhoeven (1):
      dt-bindings: usb: renesas,usbhs: Deprecate renesas,enable-gpio

Greg Kroah-Hartman (9):
      Merge 6.12-rc3 into usb-next
      Merge 6.12-rc4 into usb-next
      Merge v6.12-rc6 into usb-next
      Merge tag 'thunderbolt-for-v6.13-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      USB: make single lock for all usb dynamic id lists
      USB: properly lock dynamic id list when showing an id
      USB: make to_usb_driver() use container_of_const()
      USB: make to_usb_device_driver() use container_of_const()
      Merge tag 'usb-serial-6.13-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Heikki Krogerus (7):
      usb: typec: Add attribute file showing the supported USB modes of the port
      usb: typec: Add attribute file showing the USB Modes of the partner
      usb: typec: ucsi: Supply the USB capabilities to the ports
      usb: typec: ucsi: Add support for the partner USB Modes
      usb: typec: ucsi: Helper for Get Connector Status command
      usb: typec: ucsi: Convert connector specific commands to bitmaps
      usb: typec: ucsi: Fix a missing bits to bytes conversion in ucsi_init()

Hubert Wiśniewski (1):
      usb: musb: Fix hardware lockup on first Rx endpoint request

Icenowy Zheng (1):
      dt-bindings: usb: genesys,gl850g: allow downstream device subnodes

Jan Kiszka (1):
      USB: serial: pl2303: account for deficits of clones

Jann Horn (1):
      usb: require FMODE_WRITE for usbdev_mmap()

Javier Carrasco (1):
      usb: typec: ucsi: glink: use device_for_each_child_node_scoped()

Jeongjun Park (1):
      usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()

Jiayi Li (1):
      usb: core: use sysfs_emit() instead of sprintf()

Julia Lawall (1):
      usb: Reorganize kerneldoc parameter names

Krishna Kurapati (3):
      dt-bindings: phy: qcom,qusb2: Add bindings for QCS615
      dt-bindings: phy: qcom,msm8998-qmp-usb3-phy: Add support for QCS615
      usb: dwc3: core: Set force_gen1 bit for all applicable SuperSpeed ports

Kuangyi Chiang (4):
      xhci: Combine two if statements for Etron xHCI host
      xhci: Don't issue Reset Device command to Etron xHCI host
      xhci: Fix control transfer error on Etron xHCI host
      xhci: Don't perform Soft Retry for Etron xHCI host

Mathias Nyman (7):
      xhci: add helper to stop endpoint and wait for completion
      xhci: Add Isochronous TRB fields to TRB tracer
      xhci: Cleanup Candence controller PCI device and vendor ID usage
      xhci: show DMA address of TRB when tracing TRBs
      xhci: Don't trace ring at every enqueue or dequeue increase
      xhci: add stream context tracing
      xhci: trace stream context at Set TR Deq command completion

Michael Grzeschik (9):
      usb: gadget: uvc: wake pump everytime we update the free list
      usb: gadget: uvc: only enqueue zero length requests in potential underrun
      usb: gadget: uvc: rework to enqueue in pump worker from encoded queue
      usb: gadget: uvc: add g_parm and s_parm for frame interval
      usb: gadget: uvc: set req_size and n_requests based on the frame interval
      usb: gadget: uvc: set req_length based on payload by nreqs instead of req_size
      usb: gadget: uvc: set nbuffers to minimum STREAMING_MIN_BUFFERS in uvc_queue_setup
      usb: gadget: uvc: add trace of enqueued and completed requests
      usb: gadget: uvc: dont call usb_composite_setup_continue when not streaming

Michal Pecio (5):
      usb: xhci: Remove unused parameters of next_trb()
      usb: xhci: Fix sum_trb_lengths()
      usb: xhci: Limit Stop Endpoint retries
      usb: xhci: Fix TD invalidation under pending Set TR Dequeue
      usb: xhci: Avoid queuing redundant Stop Endpoint commands

Michal Vrastil (1):
      Revert "usb: gadget: composite: fix OS descriptors w_value logic"

Niklas Neronin (15):
      usb: xhci: introduce macro for ring segment list iteration
      usb: xhci: remove option to change a default ring's TRB cycle bit
      usb: xhci: adjust xhci_alloc_segments_for_ring() arguments
      usb: xhci: rework xhci_free_segments_for_ring()
      usb: xhci: refactor xhci_link_rings() to use source and destination rings
      usb: xhci: rework xhci_link_segments()
      usb: xhci: add xhci_initialize_ring_segments()
      usb: xhci: simplify TDs start and end naming scheme in struct 'xhci_td'
      usb: xhci: move link TRB quirk to xhci_gen_setup()
      usb: xhci: request MSI/-X according to requested amount
      usb: xhci: improve xhci_clear_command_ring()
      usb: xhci: remove unused arguments from td_to_noop()
      usb: xhci: refactor xhci_td_cleanup() to return void
      usb: xhci: add help function xhci_dequeue_td()
      usb: xhci: remove irrelevant comment

Oliver Neukum (2):
      usb: yurex: make waiting on yurex_write interruptible
      USB: chaoskey: fail open after removal

Parth Pancholi (2):
      dt-bindings: usb: add TUSB73x0 PCIe
      USB: xhci: add support for PWRON active high

Philipp Stanner (1):
      thunderbolt: Replace deprecated PCI functions

Pierre-Henry Moussay (1):
      dt-bindings: usb: add PIC64GX compatibility to mpfs-musb driver

Pooja Katiyar (1):
      usb: typec: ucsi: UCSI2.0 Set Sink Path command support

Qiu-ji Chen (1):
      USB: serial: ftdi_sio: Fix atomicity violation in get_serial_info()

R Sundar (1):
      usb: typec: tcpm: use max() to get higher value

Rex Nie (1):
      USB: core: remove dead code in do_proc_bulk()

Rob Herring (Arm) (2):
      dt-bindings: usb: cypress,cypd4226: Drop Tegra specific GPIO defines
      usb: Use (of|device)_property_present() for non-boolean properties

Romain Gantois (2):
      dt-bindings: usb: Describe TUSB1046 crosspoint switch
      usb: typec: mux: Add support for the TUSB1046 crosspoint switch

Sabyrzhan Tasbolatov (8):
      drivers/usb/gadget: refactor min with min_t
      drivers/usb/core: refactor max with max_t
      drivers/usb/host: refactor min/max with min_t/max_t
      drivers/usb/misc: refactor min with min_t
      drivers/usb/mon: refactor min with min_t
      drivers/usb/musb: refactor min/max with min_t/max_t
      drivers/usb/serial: refactor min with min_t
      drivers/usb/storage: refactor min with min_t

Saranya Gopal (1):
      usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read operations

Selvarasu Ganesan (1):
      usb: dwc3: gadget: Add missing check for single port RAM in TxFIFO resizing logic

Shen Lichuan (2):
      usb: dwc3: Correct some typos in comments
      usb: atm: Correct some typos

Stanislaw Gruszka (2):
      usb: misc: ljca: move usb_autopm_put_interface() after wait for response
      usb: misc: ljca: set small runtime autosuspend delay

Thinh Nguyen (5):
      usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
      usb: dwc3: gadget: Fix checking for number of TRBs left
      usb: dwc3: gadget: Fix looping of queued SG entries
      usb: dwc3: gadget: Cleanup SG handling
      usb: dwc3: gadget: Remove dwc3_request->needs_extra_trb

Uwe Kleine-König (2):
      usb: phy: isp1301:: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      usb: Switch back to struct platform_driver::remove()

Vitalii Mordan (1):
      usb: ehci-spear: fix call balance of sehci clk handling routines

WangYuli (1):
      xhci: debugfs: Add virt endpoint state to xhci debugfs

Xu Yang (9):
      usb: chipidea: add CI_HDRC_HAS_SHORT_PKT_LIMIT flag
      usb: chipidea: udc: limit usb request length to max 16KB
      usb: chipidea: udc: create bounce buffer for problem sglist entries if possible
      usb: chipidea: udc: handle USB Error Interrupt if IOC not set
      usb: chipidea: udc: improve dTD link logic
      usb: chipidea: udc: improve error recovery for ISO transfer
      dt-bindings: phy: imx8mq-usb: add compatible "fsl,imx95-usb-phy"
      dt-bindings: usb: dwc3-imx8mp: add compatible string for imx95
      usb: chipidea: imx: add imx8ulp support

Yan Zhen (2):
      usb: host: fix typo in the comment
      usb: gadget: udc: fix typo in the comment

Yu Jiaoliang (1):
      usb: typec: Fix typo in comment

 Documentation/ABI/testing/configfs-usb-gadget-uvc  |  64 +++
 Documentation/ABI/testing/sysfs-class-typec        |  27 ++
 .../bindings/connector/usb-connector.yaml          |  46 +-
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  42 +-
 .../bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml    |   2 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   1 +
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     |   1 +
 .../devicetree/bindings/usb/cypress,cypd4226.yaml  |   5 +-
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml   |   6 +-
 .../devicetree/bindings/usb/generic-ehci.yaml      |   1 +
 .../devicetree/bindings/usb/generic-ohci.yaml      |   1 +
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |   9 +-
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   1 +
 .../bindings/usb/microchip,mpfs-musb.yaml          |   7 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   2 +
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   4 +
 .../devicetree/bindings/usb/rockchip,dwc3.yaml     |   6 +-
 .../devicetree/bindings/usb/ti,tusb1046.yaml       |  49 ++
 .../devicetree/bindings/usb/ti,tusb73x0-pci.yaml   |  55 +++
 MAINTAINERS                                        |   7 +
 drivers/phy/realtek/phy-rtk-usb2.c                 |   2 +
 drivers/phy/realtek/phy-rtk-usb3.c                 |   2 +
 drivers/thunderbolt/debugfs.c                      | 502 +++++++++++++++------
 drivers/thunderbolt/nhi.c                          |  12 +-
 drivers/thunderbolt/sb_regs.h                      |  32 +-
 drivers/thunderbolt/tb.h                           |  16 +-
 drivers/thunderbolt/usb4.c                         |  18 +-
 drivers/usb/atm/ueagle-atm.c                       |   6 +-
 drivers/usb/atm/usbatm.c                           |   2 +-
 drivers/usb/c67x00/c67x00-drv.c                    |   2 +-
 drivers/usb/cdns3/cdns3-imx.c                      |   2 +-
 drivers/usb/cdns3/cdns3-pci-wrap.c                 |   4 +-
 drivers/usb/cdns3/cdns3-plat.c                     |   2 +-
 drivers/usb/cdns3/cdns3-starfive.c                 |   2 +-
 drivers/usb/cdns3/cdns3-ti.c                       |   2 +-
 drivers/usb/cdns3/cdnsp-pci.c                      |  26 +-
 drivers/usb/chipidea/ci.h                          |   2 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   3 +-
 drivers/usb/chipidea/ci_hdrc_msm.c                 |   2 +-
 drivers/usb/chipidea/ci_hdrc_npcm.c                |   2 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   2 +-
 drivers/usb/chipidea/ci_hdrc_usb2.c                |   2 +-
 drivers/usb/chipidea/core.c                        |   6 +-
 drivers/usb/chipidea/udc.c                         | 178 +++++++-
 drivers/usb/chipidea/udc.h                         |   2 +
 drivers/usb/chipidea/usbmisc_imx.c                 |   4 +
 drivers/usb/common/common.c                        |   3 +
 drivers/usb/common/usb-conn-gpio.c                 |   2 +-
 drivers/usb/core/config.c                          |   2 +-
 drivers/usb/core/devio.c                           |   5 +-
 drivers/usb/core/driver.c                          |  24 +-
 drivers/usb/core/endpoint.c                        |  11 +-
 drivers/usb/core/ledtrig-usbport.c                 |   3 +-
 drivers/usb/core/port.c                            |  11 +-
 drivers/usb/core/usb.h                             |   2 +-
 drivers/usb/dwc2/platform.c                        |   2 +-
 drivers/usb/dwc3/core.c                            |  16 +-
 drivers/usb/dwc3/core.h                            |  14 +-
 drivers/usb/dwc3/dwc3-am62.c                       |   2 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |   2 +-
 drivers/usb/dwc3/dwc3-imx8mp.c                     |   2 +-
 drivers/usb/dwc3/dwc3-keystone.c                   |   2 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   2 +-
 drivers/usb/dwc3/dwc3-octeon.c                     |   2 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   2 +-
 drivers/usb/dwc3/dwc3-omap.c                       |   4 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   4 +-
 drivers/usb/dwc3/dwc3-rtk.c                        |   2 +-
 drivers/usb/dwc3/dwc3-st.c                         |   2 +-
 drivers/usb/dwc3/dwc3-xilinx.c                     |   2 +-
 drivers/usb/dwc3/ep0.c                             |   4 +-
 drivers/usb/dwc3/gadget.c                          | 152 ++++---
 drivers/usb/dwc3/host.c                            |   2 +-
 drivers/usb/fotg210/fotg210-core.c                 |   2 +-
 drivers/usb/gadget/composite.c                     |  30 +-
 drivers/usb/gadget/config.c                        |   4 +-
 drivers/usb/gadget/configfs.c                      |   2 +-
 drivers/usb/gadget/function/Makefile               |   4 +
 drivers/usb/gadget/function/f_fs.c                 |   6 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   8 +-
 drivers/usb/gadget/function/f_midi.c               |   8 +-
 drivers/usb/gadget/function/f_midi2.c              |   4 +-
 drivers/usb/gadget/function/f_uvc.c                |   4 +-
 drivers/usb/gadget/function/uvc.h                  |  13 +
 drivers/usb/gadget/function/uvc_configfs.c         | 348 +++++++++++++-
 drivers/usb/gadget/function/uvc_configfs.h         |  16 +
 drivers/usb/gadget/function/uvc_queue.c            |  26 +-
 drivers/usb/gadget/function/uvc_queue.h            |   2 +
 drivers/usb/gadget/function/uvc_trace.c            |  11 +
 drivers/usb/gadget/function/uvc_trace.h            |  60 +++
 drivers/usb/gadget/function/uvc_v4l2.c             |  66 ++-
 drivers/usb/gadget/function/uvc_video.c            | 274 ++++++-----
 drivers/usb/gadget/legacy/hid.c                    |   2 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |   2 +-
 drivers/usb/gadget/udc/aspeed_udc.c                |   4 +-
 drivers/usb/gadget/udc/at91_udc.c                  |   2 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   2 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |   2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |   2 +-
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c           |   3 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |   6 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |   8 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |   2 +-
 drivers/usb/gadget/udc/fusb300_udc.c               |   4 +-
 drivers/usb/gadget/udc/gr_udc.c                    |   2 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |   2 +-
 drivers/usb/gadget/udc/m66592-udc.c                |   2 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |   2 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |   2 +-
 drivers/usb/gadget/udc/net2272.c                   |   4 +-
 drivers/usb/gadget/udc/omap_udc.c                  |   6 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |   2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |   2 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   2 +-
 drivers/usb/gadget/udc/renesas_usbf.c              |   4 +-
 drivers/usb/gadget/udc/rzv2m_usb3drd.c             |   2 +-
 drivers/usb/gadget/udc/snps_udc_core.c             |   2 +-
 drivers/usb/gadget/udc/snps_udc_plat.c             |   2 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |   2 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |   2 +-
 drivers/usb/gadget/usbstring.c                     |   2 +-
 drivers/usb/host/bcma-hcd.c                        |   1 -
 drivers/usb/host/ehci-atmel.c                      |   2 +-
 drivers/usb/host/ehci-brcm.c                       |   2 +-
 drivers/usb/host/ehci-exynos.c                     |   2 +-
 drivers/usb/host/ehci-fsl.c                        |   2 +-
 drivers/usb/host/ehci-grlib.c                      |   2 +-
 drivers/usb/host/ehci-hcd.c                        |   2 +-
 drivers/usb/host/ehci-mv.c                         |   2 +-
 drivers/usb/host/ehci-npcm7xx.c                    |   2 +-
 drivers/usb/host/ehci-omap.c                       |   2 +-
 drivers/usb/host/ehci-orion.c                      |   2 +-
 drivers/usb/host/ehci-platform.c                   |   2 +-
 drivers/usb/host/ehci-ppc-of.c                     |   2 +-
 drivers/usb/host/ehci-sh.c                         |   2 +-
 drivers/usb/host/ehci-spear.c                      |   9 +-
 drivers/usb/host/ehci-st.c                         |   2 +-
 drivers/usb/host/ehci-xilinx-of.c                  |   2 +-
 drivers/usb/host/fhci-hcd.c                        |   2 +-
 drivers/usb/host/fhci-sched.c                      |   4 +-
 drivers/usb/host/fsl-mph-dr-of.c                   |   2 +-
 drivers/usb/host/isp116x-hcd.c                     |   2 +-
 drivers/usb/host/isp1362-hcd.c                     |   2 +-
 drivers/usb/host/octeon-hcd.c                      |   6 +-
 drivers/usb/host/ohci-at91.c                       |   2 +-
 drivers/usb/host/ohci-da8xx.c                      |   2 +-
 drivers/usb/host/ohci-exynos.c                     |   2 +-
 drivers/usb/host/ohci-nxp.c                        |   2 +-
 drivers/usb/host/ohci-omap.c                       |   4 +-
 drivers/usb/host/ohci-platform.c                   |   2 +-
 drivers/usb/host/ohci-ppc-of.c                     |   2 +-
 drivers/usb/host/ohci-pxa27x.c                     |   2 +-
 drivers/usb/host/ohci-s3c2410.c                    |   2 +-
 drivers/usb/host/ohci-sm501.c                      |   2 +-
 drivers/usb/host/ohci-spear.c                      |   2 +-
 drivers/usb/host/ohci-st.c                         |   2 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   8 +-
 drivers/usb/host/r8a66597-hcd.c                    |   6 +-
 drivers/usb/host/sl811-hcd.c                       |   2 +-
 drivers/usb/host/uhci-grlib.c                      |   2 +-
 drivers/usb/host/uhci-platform.c                   |   2 +-
 drivers/usb/host/xhci-dbgcap.c                     |  13 +-
 drivers/usb/host/xhci-debugfs.c                    |  10 +-
 drivers/usb/host/xhci-histb.c                      |   2 +-
 drivers/usb/host/xhci-hub.c                        |   6 +-
 drivers/usb/host/xhci-mem.c                        | 239 +++++-----
 drivers/usb/host/xhci-mtk.c                        |   2 +-
 drivers/usb/host/xhci-pci.c                        |  45 +-
 drivers/usb/host/xhci-plat.c                       |   2 +-
 drivers/usb/host/xhci-rcar.c                       |   2 +-
 drivers/usb/host/xhci-ring.c                       | 302 ++++++++-----
 drivers/usb/host/xhci-tegra.c                      |   2 +-
 drivers/usb/host/xhci-trace.h                      |  79 +++-
 drivers/usb/host/xhci.c                            | 121 +++--
 drivers/usb/host/xhci.h                            |  51 ++-
 drivers/usb/isp1760/isp1760-if.c                   |   2 +-
 drivers/usb/misc/chaoskey.c                        |  35 +-
 drivers/usb/misc/iowarrior.c                       |  50 +-
 drivers/usb/misc/onboard_usb_dev.c                 |   2 +-
 drivers/usb/misc/qcom_eud.c                        |   2 +-
 drivers/usb/misc/usb-ljca.c                        |  20 +-
 drivers/usb/misc/usb3503.c                         |   2 +-
 drivers/usb/misc/usbtest.c                         |   3 +-
 drivers/usb/misc/yurex.c                           |   5 +-
 drivers/usb/mon/mon_bin.c                          |   2 +-
 drivers/usb/mtu3/mtu3_plat.c                       |   4 +-
 drivers/usb/musb/da8xx.c                           |   2 +-
 drivers/usb/musb/jz4740.c                          |   2 +-
 drivers/usb/musb/mediatek.c                        |   2 +-
 drivers/usb/musb/mpfs.c                            |   2 +-
 drivers/usb/musb/musb_core.c                       |   4 +-
 drivers/usb/musb/musb_dsps.c                       |   2 +-
 drivers/usb/musb/musb_gadget.c                     |  13 +-
 drivers/usb/musb/musb_gadget_ep0.c                 |   2 +-
 drivers/usb/musb/musb_host.c                       |   5 +-
 drivers/usb/musb/omap2430.c                        |   2 +-
 drivers/usb/musb/sunxi.c                           |   2 +-
 drivers/usb/musb/tusb6010.c                        |   2 +-
 drivers/usb/musb/ux500.c                           |   2 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |   2 +-
 drivers/usb/phy/phy-am335x.c                       |   2 +-
 drivers/usb/phy/phy-fsl-usb.c                      |   2 +-
 drivers/usb/phy/phy-generic.c                      |   2 +-
 drivers/usb/phy/phy-gpio-vbus-usb.c                |   2 +-
 drivers/usb/phy/phy-isp1301.c                      |   2 +-
 drivers/usb/phy/phy-keystone.c                     |   2 +-
 drivers/usb/phy/phy-mv-usb.c                       |   2 +-
 drivers/usb/phy/phy-mxs-usb.c                      |   2 +-
 drivers/usb/phy/phy-tahvo.c                        |   2 +-
 drivers/usb/phy/phy-tegra-usb.c                    |   2 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |   2 +-
 drivers/usb/phy/phy.c                              |   2 +-
 drivers/usb/renesas_usbhs/common.c                 |   4 +-
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |   2 +-
 drivers/usb/serial/bus.c                           |   4 +-
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/io_edgeport.c                   |   2 +-
 drivers/usb/serial/pl2303.c                        |  38 +-
 drivers/usb/serial/sierra.c                        |   2 +-
 drivers/usb/serial/usb-serial.c                    |   4 +-
 drivers/usb/storage/ene_ub6250.c                   |   8 +-
 drivers/usb/storage/realtek_cr.c                   |   4 +-
 drivers/usb/storage/sddr09.c                       |   4 +-
 drivers/usb/storage/sddr55.c                       |   8 +-
 drivers/usb/storage/transport.c                    |   2 +-
 drivers/usb/typec/altmodes/displayport.c           |   2 +-
 drivers/usb/typec/class.c                          | 205 ++++++++-
 drivers/usb/typec/class.h                          |   3 +
 drivers/usb/typec/mux/Kconfig                      |   9 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/gpio-sbu-mux.c               |   2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |   2 +-
 drivers/usb/typec/mux/tusb1046.c                   | 196 ++++++++
 drivers/usb/typec/stusb160x.c                      |   7 +-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      |   2 +-
 drivers/usb/typec/tcpm/tcpci_mt6360.c              |   2 +-
 drivers/usb/typec/tcpm/tcpci_mt6370.c              |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  96 +++-
 drivers/usb/typec/tcpm/wcove.c                     |   2 +-
 drivers/usb/typec/ucsi/debugfs.c                   |   1 +
 drivers/usb/typec/ucsi/psy.c                       |  28 +-
 drivers/usb/typec/ucsi/trace.h                     |  28 +-
 drivers/usb/typec/ucsi/ucsi.c                      | 153 ++++---
 drivers/usb/typec/ucsi/ucsi.h                      | 245 ++++++----
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  65 +--
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   5 +
 drivers/usb/typec/ucsi/ucsi_glink.c                |  21 +-
 drivers/usb/usbip/vhci_hcd.c                       |   2 +-
 drivers/usb/usbip/vudc_main.c                      |   2 +-
 include/linux/pci_ids.h                            |   4 +
 include/linux/usb.h                                |   7 +-
 include/linux/usb/chipidea.h                       |   1 +
 include/linux/usb/storage.h                        |   2 +-
 include/linux/usb/typec.h                          |  22 +
 include/uapi/linux/usb/video.h                     |  58 +++
 257 files changed, 3507 insertions(+), 1354 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb1046.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
 create mode 100644 drivers/usb/gadget/function/uvc_trace.c
 create mode 100644 drivers/usb/gadget/function/uvc_trace.h
 create mode 100644 drivers/usb/typec/mux/tusb1046.c

