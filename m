Return-Path: <linux-kernel+bounces-425221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4E9DBF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA02B222DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7A154BE0;
	Fri, 29 Nov 2024 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nxeZ61N/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C7154BFC;
	Fri, 29 Nov 2024 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854479; cv=none; b=o/9l5F7i/J4l0Ttign4VRztAgR9Oregj0oQLko/vJMi05JfDWcf509ytKW1Dn+ZLb3Zsi/E5+YhVaKW9h4RkULQHrJ6ZqaH+uKnmACtcP8BXhzTPa3D83n0mUwvRZECHWSKDJ23B9jBgHdd9JgK7qPVr8g+pSDPKVgqt25aFX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854479; c=relaxed/simple;
	bh=5IHgpn9NY0Zy6BT9fa0pAGMsGlRGBMeRRK9Yy0cm2JU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=It4yS7ITooRfi5Parsc3s1n8bVCXBRTx24epLbjQhWkBRTCqDy/vBWV/X3vzdJTBjAQzA5QhPqBsyZuliJBPyFvpL532Kic0xb/K8EnqdnCQkYiws8WI9KAaJ0PFqgZIaWVOl9ZwqWLfp/rpt5MTY4hoxfflaHkwc2RRTkdqOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nxeZ61N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70243C4CECF;
	Fri, 29 Nov 2024 04:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732854478;
	bh=5IHgpn9NY0Zy6BT9fa0pAGMsGlRGBMeRRK9Yy0cm2JU=;
	h=Date:From:To:Cc:Subject:From;
	b=nxeZ61N/o206yjMWFyJzwmI6MJkmo0Ukz04T0zNnABCd7flMzcasiK1bJHK+l9Tp2
	 Y8SQdiZJHcK+xjX97+LsVQ5Q6FSZX6xSPNSYamNi5ZaoQXfZkV5UyBBd2yBF9/PARy
	 Gnu98wi/hLwDyt0slWft357FiWqCzjoIJZsX0R6g=
Date: Fri, 29 Nov 2024 05:27:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 6.13-rc1
Message-ID: <Z0lCyXBV06VyH96s@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc1

for you to fetch changes up to 114eae3c9fde35220cca623840817a740a2eb7b3:

  Staging: gpib: gpib_os.c - Remove unnecessary OOM message (2024-11-10 08:04:18 +0100)

----------------------------------------------------------------
Staging driver changes for 6.13-rc1

Here is the big set of staging driver changes for 6.13-rc1.

Lots of changes this merge cycle, drivers removed and drivers added.
Highlights include:
  - removals of the following staging drivers due to no forward progress
    and no one having either the hardware or the time/energy to deal
    with them anymore:
      - fieldbus
      - gdm724x
      - olpc_dcon
      - rtl8712
      - rts5208
      - vt6655
      - vt6656
    If anyone has this hardware and wants to work on the drivers, it can
    be an easy revert to get them back.
 - addition of the gpib driver subsystem.  Lots of drivers for
   really old and semi-old interfaces to lab equipments.  We expect lots
   of churn in these drivers as they get cleaned up to "working" order.
   These were added at the request of a user and the maintainer/author
   of them is helping out with the effort
 - loads and loads of tiny coding style cleanups for almost all staging
   drivers.  Too many to list, see the shortlog for details.

Note, this pull request contains a portion of the wireless tree, as the
removal of some of the staging wifi drivers came in through there to
coordinate things.  These should already be in your tree already, so the
diffstat will (and should) look different when you do your merge.

All of these have been in linux-next for a very long time with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhishek Tamboli (1):
      staging: octeon: Use new initialization api for tasklet

Aleksander Jan Bajkowski (1):
      net: macb: Adding support for Jumbo Frames up to 10240 Bytes in SAMA5D2

Alexandre Ferrieux (1):
      ipv4: avoid quadratic behavior in FIB insertion of common address

Amit Cohen (1):
      selftests: mlxsw: rtnetlink: Use devlink_reload() API

Andrew Kreimer (1):
      fsl/fman: Fix a typo

Arnd Bergmann (7):
      staging: gpib: add module descriptions
      staging: gpib: avoid unused const variables
      staging: gpib: pc2: avoid calling undefined dma_free()
      staging: gpib: make port I/O code conditional
      staging: gpib: add bus specific Kconfig dependencies
      staging: gpib: use proper format string in request_module
      staging: gpib: cb7210: select NEC7210 library

Aryan Srivastava (1):
      net: dsa: mv88e6xxx: Add FID map cache

Bartosz Golaszewski (1):
      net: phy: smsc: use devm_clk_get_optional_enabled_with_rate()

Christophe JAILLET (1):
      mlxsw: spectrum_acl_flex_keys: Constify struct mlxsw_afk_element_inst

Colin Ian King (2):
      cxgb4: clip_tbl: Fix spelling mistake "wont" -> "won't"
      tcp: Fix spelling mistake "emtpy" -> "empty"

Cosmin Ratiu (6):
      net/mlx5: hw counters: Make fc_stats & fc_pool private
      net/mlx5: hw counters: Use kvmalloc for bulk query buffer
      net/mlx5: hw counters: Replace IDR+lists with xarray
      net/mlx5: hw counters: Drop unneeded cacheline alignment
      net/mlx5: hw counters: Don't maintain a counter count
      net/mlx5: hw counters: Remove mlx5_fc_create_ex

Dan Carpenter (1):
      staging: gpib: fix uninitialized variable in usb_gpib_command()

Daniel Golle (4):
      net: phy: mxl-gpy: add basic LED support
      net: phy: mxl-gpy: add missing support for TRIGGER_NETDEV_LINK_10
      dt-bindings: net: marvell,aquantia: add property to override MDI_CFG
      net: phy: aquantia: allow forcing order of MDI pairs

Daniel Machon (15):
      net: sparx5: add support for private match data
      net: sparx5: add indirection layer to register macros
      net: sparx5: modify SPX5_PORTS_ALL macro
      net: sparx5: add *sparx5 argument to a few functions
      net: sparx5: add constants to match data
      net: sparx5: use SPX5_CONST for constants which already have a symbol
      net: sparx5: use SPX5_CONST for constants which do not have a symbol
      net: sparx5: add ops to match data
      net: sparx5: ops out chip port to device index/bit functions
      net: sparx5: ops out functions for getting certain array values
      net: sparx5: ops out function for setting the port mux
      net: sparx5: ops out PTP IRQ handler
      net: sparx5: ops out function for DSM calendar calculation
      net: sparx5: add is_sparx5 macro and use it throughout
      net: sparx5: redefine internal ports and PGID's as offsets

Daniel Zahka (1):
      ethtool: rss: fix rss key initialization warning

Danilo Pereira (1):
      staging: vchiq_arm: removes multiple blank lines

Dave Penkler (33):
      staging: gpib: Add common include files for GPIB drivers
      staging: gpib: Add user api include files
      staging: gpib: Add GPIB common core driver
      staging: gpib: Add tms9914 GPIB chip driver
      staging: gpib: Add nec7210 GPIB chip driver
      staging: gpib: Add HP/Agilent/Keysight 8235xx PCI GPIB driver
      staging: gpib: Add Agilent/Keysight 82357x USB GPIB driver
      staging: gpib: Add Computer Boards GPIB driver
      staging: gpib: Add Computer Equipment Corporation GPIB driver
      staging: gpib: Add Fluke cda based cards GPIB driver
      staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver
      staging: gpib: Add gpio bitbang GPIB driver
      staging: gpib: Add hp82335x GPIB driver
      staging: gpib: Add hp82341x GPIB driver
      staging: gpib: Add ines GPIB driver
      staging: gpib: Add LPVO DIY USB GPIB driver
      staging: gpib: Add National Instruments USB GPIB driver
      staging: gpib: Add pc2 GPIB driver
      staging: gpib: Add TNT4882 chip based GPIB driver
      staging: gpib: Add KBUILD files for GPIB drivers
      staging: gpib: Add GPIB driver maintainer
      staging: gpib: Fix buffer overflow in ni_usb_init
      staging: gpib: Replace custom debug with dev_dbg
      staging: gpib: Update messaging and usb_device refs in ni_usb
      staging: gpib: Update messaging and usb_device refs in agilent_usb
      staging: gpib: Fix MODULES_DESCRIPTION
      staging: gpib: Add comment for mutex define
      staging: gpib: Use dev_xxx for messaging
      staging: gpib: Fix Kconfig
      staging: gpib: Remove unneeded lookup table
      staging: gpib: Remove GPIO14 and GPIO15 lines in lookup tables
      staging: gpib: Re-order the lookup tables
      staging: gpib: Correct check for max secondary address

David S. Miller (1):
      Merge branch 'sfc-per-q-stats'

Divya Koppera (1):
      net: phy: microchip_t1: Interrupt support for lan887x

Dmitry Antipov (1):
      wifi: mac80211, cfg80211: miscellaneous spelling fixes

Dmitry Kandybka (1):
      wifi: nl80211: remove redundant null pointer check in coalescing

Dominik Karol Piątkowski (25):
      staging: vt6656: Update maintainer in TODO
      staging: vt6655: rxtx.c: Fix too long lines in get_rtscts_time
      staging: vt6655: s_uGetDataDuration: Rename pDevice parameter
      staging: vt6655: s_uGetDataDuration: Rename byDurType parameter
      staging: vt6655: s_uGetDataDuration: Rename cbFrameLength parameter
      staging: vt6655: s_uGetDataDuration: Rename byPktType parameter
      staging: vt6655: s_uGetDataDuration: Rename wRate parameter
      staging: vt6655: s_uGetDataDuration: Rename bNeedAck parameter
      staging: vt6655: s_uGetDataDuration: Rename uFragIdx parameter
      staging: vt6655: s_uGetDataDuration: Rename cbLastFragmentSize parameter
      staging: vt6655: s_uGetDataDuration: Rename uMACfragNum parameter
      staging: vt6655: s_uGetDataDuration: Rename byFBOption parameter
      staging: vt6655: s_uGetDataDuration: Rename bLastFrag variable
      staging: vt6655: s_uGetDataDuration: Rename uAckTime variable
      staging: vt6655: s_uGetDataDuration: Rename uNextPktTime variable
      staging: vt6655: s_uGetDataDuration: Fix declaration formatting
      staging: rtl8712: Rename AuthAlgrthm variable
      staging: rtl8712: Rename PrivacyAlgrthm variable
      staging: rtl8712: Introduce auth_algorithm macros
      staging: gpib: fmh_gpib: Fix typo
      staging: gpib: Add TODO file
      staging: iio: Remove TODO file
      staging: sm750fb: Remove TODO contact information
      staging: rtl8723bs: Remove TODO contact information
      staging: most: Remove TODO contact information

Dr. David Alan Gilbert (4):
      net/rds: remove unused struct 'rds_ib_dereg_odp_mr'
      appletalk: Remove deadcode
      caif: Remove unused cfsrvl_getphyid
      chelsio/chtls: Remove unused chtls_set_tcb_tflag

Edward Cree (7):
      sfc: remove obsolete counters from struct efx_channel
      sfc: implement basic per-queue stats
      sfc: add n_rx_overlength to ethtool stats
      sfc: account XDP TXes in netdev base stats
      sfc: implement per-queue rx drop and overrun stats
      sfc: implement per-queue TSO (hw_gso) stats
      sfc: add per-queue RX bytes stats

Eric Dumazet (8):
      tcp: annotate data-races around icsk->icsk_pending
      tcp: add a fast path in tcp_write_timer()
      tcp: add a fast path in tcp_delack_timer()
      net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute
      ipv4: remove fib_devindex_hashfn()
      ipv4: use rcu in ip_fib_check_default()
      ipv4: remove fib_info_lock
      ipv4: remove fib_info_devhash[]

Erni Sri Satya Vennela (1):
      net: mana: Add get_link and get_link_ksettings in ethtool

Everest K.C. (4):
      staging: gpib: Move free after the variable use has been completed
      staging: gpib: Remove unused value
      staging: gpib: Change return type and error code of fluke_get_dma_residue
      staging: gpib: Change return type and error code of fmh_gpib_get_dma_residue()

FUJITA Tomonori (1):
      rust: net::phy always define device_table in module_phy_driver macro

Francesco Dolcini (3):
      dt-bindings: net: fec: add pps channel property
      net: fec: refactor PPS channel configuration
      net: fec: make PPS channel configurable

Greg Kroah-Hartman (4):
      Merge wireless-next into staging-next
      staging: gpib: disable CONFIG_GPIB_KERNEL_DEBUG
      staging: gpib: mark HP82341 driver as broken
      staging: gpib: mark FMH driver as broken

Guillaume Nault (5):
      ipv4: Convert icmp_route_lookup() to dscp_t.
      ipv4: Convert ip_route_input() to dscp_t.
      ipv4: Convert ip_route_input_noref() to dscp_t.
      ipv4: Convert ip_route_input_rcu() to dscp_t.
      ipv4: Convert ip_route_input_slow() to dscp_t.

Hans de Goede (1):
      staging: rtl8723bs: Remove no-op netdevice_notifier()

Hridesh MG (1):
      staging: vchiq_core: Fix white space indentation error

Jacob Keller (3):
      lib: packing: add KUnit tests adapted from selftests
      lib: packing: add additional KUnit tests
      lib: packing: fix QUIRK_MSB_ON_THE_RIGHT behavior

Jacobe Zang (4):
      dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
      dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
      wifi: brcmfmac: Add optional lpo clock enable support
      wifi: brcmfmac: add flag for random seed during firmware download

Jakub Kicinski (22):
      Merge branch 'net-pcs-xpcs-cleanups-batch-1'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'packing-various-improvements-and-kunit-tests'
      Merge branch 'ena-link-irqs-queues-and-napi-instances'
      Merge branch 'ipv4-convert-ip_route_input_slow-and-its-callers-to-dscp_t'
      Merge branch 'gve-link-irqs-queues-and-napi-instances'
      Merge branch 'net-ag71xx-small-cleanups'
      Merge branch 'net-mv643xx-devm-fixes'
      Merge branch 'qed-ethtool-d-faster-less-latency'
      Merge branch 'net-switch-to-scoped-device_for_each_child_node'
      Merge branch 'net-airoha-fix-pse-memory-configuration'
      Merge branch 'net-mlx5-hw-counters-refactor'
      Merge branch 'add-option-to-provide-opt_id-value-via-cmsg'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'selftests-net-ioam-add-tunsrc-support'
      Merge branch 'tcp-add-fast-path-in-timer-handlers'
      Merge branch 'net-prepare-pacing-offload-support'
      Merge branch 'net-switch-back-to-struct-platform_driver-remove'
      Merge branch 'ipv4-preliminary-work-for-per-netns-rtnl'
      tools: ynl-gen: refactor check validation for TypeBinary
      Merge branch 'selftests-mlxsw-stabilize-red-tests'
      Merge branch 'net-phy-marvell-88q2xxx-enable-auto-negotiation-for-mv88q2110'

Jason Xing (1):
      net-timestamp: namespacify the sysctl_tstamp_allow_data

Javier Carrasco (4):
      net: mdio: thunder: switch to scoped device_for_each_child_node()
      net: hns: hisilicon: hns_dsaf_mac: switch to scoped device_for_each_child_node()
      staging: vchiq_arm: refactor goto instructions in vchiq_probe()
      staging: vchiq_arm: Fix missing refcount decrement in error path for fw_node

Jeff Johnson (1):
      wifi: mac80211: constify ieee80211_ie_build_{he,eht}_oper() chandef

Jeffrey Ji (1):
      net_sched: sch_fq: add the ability to offload pacing

Jinjie Ruan (3):
      wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()

Joe Damato (6):
      ena: Link IRQs to NAPI instances
      ena: Link queues to NAPIs
      gve: Map IRQs to NAPI instances
      gve: Map NAPI instances to queues
      hv_netvsc: Link queues to NAPIs
      idpf: Don't hard code napi_struct size

Johannes Berg (14):
      wifi: qtnfmac: don't include lib80211.h
      wifi: mwifiex: don't include lib80211.h
      wifi: libertas: don't select/include lib80211
      staging: rtl8192e: delete the driver
      wifi: ipw2x00/lib80211: move remaining lib80211 into libipw
      staging: don't recommend using lib80211
      wifi: wext/libipw: move spy implementation to libipw
      wifi: cfg80211: stop exporting wext symbols
      wifi: remove iw_public_data from struct net_device
      wifi: cfg80211: unexport wireless_nlevent_flush()
      wifi: wext: merge adjacent CONFIG_COMPAT ifdef blocks
      wireless: wext: shorten struct iw_ioctl_description
      Revert "wifi: cfg80211: unexport wireless_nlevent_flush()"
      Merge net-next/main to resolve conflicts

Julia Lawall (1):
      mac80211: Reorganize kerneldoc parameter names

Justin Iurman (2):
      selftests: net: remove ioam tests
      selftests: net: add new ioam tests

Karol Kolacinski (5):
      ice: Implement ice_ptp_pin_desc
      ice: Add SDPs support for E825C
      ice: Align E810T GPIO to other products
      ice: Cache perout/extts requests and check flags
      ice: Disable shared pin on E810 on setfunc

Karthikeyan Periyasamy (1):
      wifi: cfg80211: check radio iface combination for multi radio per wiphy

Kees Bakker (2):
      staging: gpib: replace dump function by print_hex_dump
      staging: gpib: avoid unintended sign extension

Kuniyuki Iwashima (4):
      Revert "rtnetlink: add guard for RTNL"
      rtnetlink: Add per-netns RTNL.
      rtnetlink: Add assertion helpers for per-netns RTNL.
      rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.

Linus Walleij (2):
      net: dsa: mv88e6xxx: Support LED control
      dt-bindings: net: realtek: Use proper node names

Lorenzo Bianconi (2):
      net: airoha: read default PSE reserved pages value before updating
      net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()

Mahesh Bandewar (1):
      selftest/ptp: update ptp selftest to exercise the gettimex options

Manuel Quintero F (1):
      staging: rtl8723bs: core: rtw_cmd: Missing a blank line after declarations

Menglong Dong (1):
      net: tcp: refresh tcp_mstamp for compressed ack in timer

Michael Harris (1):
      Staging: rtl8723bs: hal: odm: removed unnecessary braces

Michael Kelley (1):
      hv_netvsc: Don't assume cpu_possible_mask is dense

Michal Schmidt (4):
      qed: make 'ethtool -d' 10 times faster
      qed: put cond_resched() in qed_grc_dump_ctx_data()
      qed: allow the callee of qed_mcp_nvm_read() to sleep
      qed: put cond_resched() in qed_dmae_operation_wait()

Nathan Chancellor (2):
      staging: gpib: Fix PCI header include guard
      staging: gpib: fmh: Drop residue from fmh_gpid_fifo_read_countable()

Nick Child (1):
      ibmvnic: Add stat for tx direct vs tx batched

Niklas Söderlund (3):
      net: phy: marvell-88q2xxx: Align soft reset for mv88q2110 and mv88q2220
      net: phy: marvell-88q2xxx: Make register writer function generic
      net: phy: marvell-88q2xxx: Enable auto negotiation for mv88q2110

Oleksij Rempel (3):
      dt-bindings: net: ethernet-phy: Add timing-role role property for ethernet PHYs
      net: phy: Add support for PHY timing-role configuration via device tree
      Documentation: networking: add Twisted Pair Ethernet diagnostics at OSI Layer 1

Omer Faruk BULUT (1):
      Staging: gpib: gpib_os.c - Remove unnecessary OOM message

Paolo Abeni (4):
      Merge branch 'net-phy-support-master-slave-config-via-device-tree'
      Merge branch 'net-sparx5-prepare-for-lan969x-switch-driver'
      Merge branch 'net-fec-add-pps-channel-configuration'
      Merge branch 'rtnetlink-per-netns-rtnl'

Pedro Perez (1):
      staging: vme_user: vme_bridge.h: Name function pointer arguments

Petr Machata (5):
      selftests: mlxsw: sch_red_ets: Increase required backlog
      selftests: mlxsw: sch_red_core: Increase backlog size tolerance
      selftests: mlxsw: sch_red_core: Sleep before querying queue depth
      selftests: mlxsw: sch_red_core: Send more packets for drop tests
      selftests: mlxsw: sch_red_core: Lower TBF rate

Philipp Hortmann (84):
      staging: rtl8723bs: Remove unused function dvobj_get_port0_adapter
      staging: rtl8723bs: Remove unused function rtw_search_max_mac_id
      staging: rtl8723bs: Remove unused function read_cam
      staging: rtl8723bs: Remove unused function rtw_get_oper_choffset
      staging: rtl8723bs: Remove unused function rtw_get_oper_bw
      staging: rtl8723bs: Remove unused function _ReadCAM
      staging: rtl8723bs: Remove unused entries from struct hal_ops
      staging: rtl8723bs: Remove unused function PHY_SetBWMode8723B
      staging: rtl8723bs: Remove unused function PHY_GetTxPowerLevel8723B
      staging: rtl8723bs: Remove unused function Hal_BT_EfusePowerSwitch
      staging: rtl8723bs: Remove unused function rtl8723b_GetHalODMVar
      staging: rtl8723bs: Remove unused function GetHalODMVar
      staging: rtl8723bs: Remove unused function rtl8723bs_inirp_init
      staging: rtl8723bs: Remove unused function rtl8723bs_inirp_deinit
      staging: rtl8723bs: Remove constant result macro is_primary_adapter
      staging: rtl8723bs: Remove constant result macro get_iface_type
      staging: rtl8723bs: Remove unused enum with first entry IFACE_PORT0
      staging: rtl8723bs: Remove function pointer hal_init
      staging: rtl8723bs: Remove function pointer hal_deinit
      staging: rtl8723bs: Remove function pointer free_hal_data
      staging: rtl8723bs: Remove function pointer init_xmit_priv
      staging: rtl8723bs: Remove function pointer free_xmit_priv
      staging: rtl8723bs: Remove function pointer init_recv_priv
      staging: rtl8723bs: Remove function pointer free_recv_priv
      staging: rtl8723bs: Remove function pointer dm_init
      staging: rtl8723bs: Remove function pointer dm_deinit
      staging: rtl8723bs: Remove function pointer read_chip_version
      staging: rtl8723bs: Remove function pointer init_default_value
      staging: rtl8723bs: Remove function pointer intf_chip_configure
      staging: rtl8723bs: Remove function pointer read_adapter_info
      staging: rtl8723bs: Remove function pointer enable_interrupt
      staging: rtl8723bs: Remove function pointer disable_interrupt
      staging: rts5208: Remove unused driver
      staging: vt6655: Remove unused driver
      staging: gdm724x: Remove unused driver
      staging: vt6656: Remove unused driver
      staging: olpc_dcon: Remove driver marked as broken since 2022
      staging: rtl8712: Remove driver using deprecated API wext
      staging: fieldbus: Delete unused driver
      staging: rtl8723bs: Replace function thread_enter
      staging: rtl8723bs: Remove #if 1 in function hal_EfusePartialWriteCheck
      staging: rtl8723bs: Remove #if 1 in function hal_EfuseGetCurrentSize_BT
      staging: rtl8723bs: Remove #if 1 in function ReadChipVersion8723B
      staging: rtl8723bs: Remove function pointer check_ips_status
      staging: rtl8723bs: Remove function pointer SetHwRegHandler
      staging: rtl8723bs: Remove function pointer GetHwRegHandler
      staging: rtl8723bs: Remove function pointer SetHwRegHandlerWithBuf
      staging: rtl8723bs: Remove function pointer GetHalDefVarHandler
      staging: rtl8723bs: Remove function pointer SetHalDefVarHandler
      staging: rtl8723bs: Remove function pointer hal_xmit
      staging: rtl8723bs: Remove function pointer mgnt_xmit
      staging: rtl8723bs: Remove function pointer hal_xmitframe_enqueue
      staging: rtl8723bs: Remove function pointer UpdateRAMaskHandler
      staging: rtl8723bs: Remove function pointer set_channel_handler
      staging: rtl8723bs: Remove function pointer set_chnl_bw_handler
      staging: rtl8723bs: Remove function pointer set_tx_power_level_handler
      staging: rtl8723bs: Remove function pointer hal_dm_watchdog
      staging: rtl8723bs: Remove function pointer hal_dm_watchdog_in_lps
      staging: rtl8723bs: Remove function pointer SetBeaconRelatedRegistersHandler
      staging: rtl8723bs: Remove function pointer Add_RateATid
      staging: rtl8723bs: Remove function pointer run_thread
      staging: rtl8723bs: Remove function pointer cancel_thread
      staging: rtl8723bs: Remove function pointer read_bbreg
      staging: rtl8723bs: Remove function pointer write_bbreg
      staging: rtl8723bs: Remove function pointer read_rfreg
      staging: rtl8723bs: Remove function pointer write_rfreg
      staging: rtl8723bs: Remove function pointer EfusePowerSwitch
      staging: rtl8723bs: Remove function pointer ReadEFuse
      staging: rtl8723bs: Remove function pointer EFUSEGetEfuseDefinition
      staging: rtl8723bs: Remove function pointer EfuseGetCurrentSize
      staging: rtl8723bs: Remove unused function Efuse_PgPacketRead
      staging: rtl8723bs: Remove unused function Hal_EfusePgPacketRead
      staging: rtl8723bs: Remove unused function Efuse_PgPacketWrite
      staging: rtl8723bs: Remove unused function Hal_EfusePgPacketWrite
      staging: rtl8723bs: Remove unused function Hal_EfusePgPacketWrite_BT
      staging: rtl8723bs: Remove unused function hal_EfusePgPacketWriteData
      staging: rtl8723bs: Remove unused function hal_EfusePgPacketWriteHeader
      staging: rtl8723bs: Remove unused function hal_EfusePartialWriteCheck
      staging: rtl8723bs: Remove unused function hal_EfuseConstructPGPkt
      staging: rtl8723bs: Remove unused function hal_EfusePgCheckAvailableAddr
      staging: rtl8723bs: Remove function hal_EfusePgPacketWrite2ByteHeader
      staging: rtl8723bs: Remove function hal_EfusePgPacketWrite1ByteHeader
      staging: rtl8723bs: Remove unused function efuse_WordEnableDataRead
      staging: rtl8723bs: Remove unused function Efuse_GetCurrentSize

Qiu-ji Chen (1):
      staging: greybus: uart: Fix atomicity violation in get_serial_info()

Riyan Dhiman (1):
      octeontx2-af: Change block parameter to const pointer in get_lf_str_list

Rodrigo Gobbi (3):
      staging: gdm724x: fix returning -1 with return equivalent errors
      staging: rtl8723bs: remove unused debug statements
      staging: rtl8723bs: change remaining printk to proper api

Rohit Chavan (3):
      staging: gpib: Remove unneeded semicolon.
      staging: gpib: Replace kmalloc/memset with kzalloc.
      staging: vchiq_core: Remove unnecessary blank lines

Ronak Doshi (1):
      vmxnet3: support higher link speeds from vmxnet3 v9

Rosen Penev (9):
      net: marvell: mvmdio: use clk_get_optional
      net: ag71xx: use devm_ioremap_resource
      net: ag71xx: use some dev_err_probe
      net: ag71xx: remove platform_set_drvdata
      net: ag71xx: replace INIT_LIST_HEAD
      net: ag71xx: move assignment into main loop
      net: mv643xx: use devm_platform_ioremap_resource
      net: mv643xx: fix wrong devm_clk_get usage
      staging: greybus: gpio: use gpiochip_get_data

Russell King (Oracle) (11):
      net: pcs: xpcs: move PCS reset to .pcs_pre_config()
      net: pcs: xpcs: drop interface argument from internal functions
      net: pcs: xpcs: get rid of xpcs_init_iface()
      net: pcs: xpcs: add xpcs_destroy_pcs() and xpcs_create_pcs_mdiodev()
      net: wangxun: txgbe: use phylink_pcs internally
      net: dsa: sja1105: simplify static configuration reload
      net: dsa: sja1105: call PCS config/link_up via pcs_ops structure
      net: dsa: sja1105: use phylink_pcs internally
      net: pcs: xpcs: drop interface argument from xpcs_create*()
      net: pcs: xpcs: make xpcs_do_config() and xpcs_link_up() internal
      net: dsa: remove obsolete phylink dsa_switch operations

Sam Edwards (1):
      net: dsa: bcm_sf2: fix crossbar port bitwidth logic

Sean Anderson (1):
      selftests: net: csum: Clean up recv_verify_packet_ipv6

Sergey Temerkhanov (6):
      ice: Enable 1PPS out from CGU for E825C products
      ice: Introduce ice_get_phy_model() wrapper
      ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
      ice: Initial support for E825C hardware in ice_adapter
      ice: Use ice_adapter for PTP shared data instead of auxdev
      ice: Drop auxbus use for PTP to finalize ice_adapter move

Sergio Paracuellos (1):
      staging: Switch back to struct platform_driver::remove()

Shradha Gupta (1):
      net: mana: Increase the DEF_RX_BUFFERS_PER_QUEUE to 1024

Stefan Wahren (1):
      staging: vc04_services: TESTING: Adjust ping test

Tarun Alle (1):
      net: phy: microchip_t1: SQI support for LAN887x

Tudor Gheorghiu (1):
      staging: rtl8712: use kmalloc_array

Umang Jain (31):
      staging: vchiq_core: Use killable wait completions for bulk transfers
      staging: vchiq_core: Return on all errors from queue_message()
      staging: vchiq_core: Return -EINTR in queue_message() on interrupt
      staging: vchiq_core: Return -EINTR when bulk transfers are interrupted
      staging: vchiq_arm: Do not retry bulk transfers on -EINTR
      staging: vchiq_core: Drop retry loop on -EINTR
      staging: vchiq_core: Move remote_event_signal() vchiq_core
      staging: vchiq_core: Move bulk data functions in vchiq_core
      staging: vchiq_core: Drop vchiq_pagelist.h
      staging: vchiq_core: Indent static_assert on single line
      staging: vchiq_core: Locally cache cache_line_size information
      staging: vchiq_core: Do not log debug in a separate scope
      staging: vchiq_core: Indent copy_message_data() on a single line
      staging: vchiq_core: Refactor notify_bulks()
      staging: vchiq_core: Lower indentation in parse_open()
      staging: vchiq_core: Lower indentation in vchiq_close_service_internal
      staging: vchiq_core: Subsume 'offset' in struct vchiq_bulk
      staging: vchiq_core: Simplify bulk data preparatory functions
      staging: vc04_services: Simplify block bulk transfer code paths
      staging: vc04_services: Simplify (no)callback bulk transfer code paths
      staging: vchiq_core: Simplify bulk transfer queue message function
      staging: vchiq_dev: Drop userdata local pointer
      staging: vchiq_arm: Rename a struct vchiq_bulk member
      staging: vchiq_core: Bulk waiter should not piggy back on bulk userdata
      staging: vchiq_core: Rename struct vchiq_bulk 'userdata'
      staging: vchiq: Rename vchiq_completion_data 'bulk_userdata'
      staging: vchiq_core: Pass vchiq_bulk pointer to make_service_callback()
      staging: vchiq_arm: Track bulk user data pointer separately
      staging: vc04_services: Cleanup TODO entry
      staging: vchiq_core: Rectify header include for vchiq_dump_state()
      staging: vchiq_debugfs: Use forward declarations

Uwe Kleine-König (6):
      net: ethernet: Switch back to struct platform_driver::remove()
      net: dsa: Switch back to struct platform_driver::remove()
      net: mdio: Switch back to struct platform_driver::remove()
      net: Switch back to struct platform_driver::remove()
      staging: most: i2c: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      staging: olpc_dcon: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Vadim Fedorenko (3):
      net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
      net_tstamp: add SCM_TS_OPT_ID for RAW sockets
      selftests: txtimestamp: add SCM_TS_OPT_ID test

Vasileios Amoiridis (3):
      wifi: brcmfmac: of: Make use of irq_get_trigger_type()
      wifi: wlcore: sdio: Make use of irq_get_trigger_type()
      wifi: wlcore: sdio: Use helper to define resources

Vladimir Oltean (8):
      lib: packing: refuse operating on bit indices which exceed size of buffer
      lib: packing: adjust definitions and implementation for arbitrary buffer lengths
      lib: packing: remove kernel-doc from header file
      lib: packing: add pack() and unpack() wrappers over packing()
      lib: packing: duplicate pack() and unpack() implementations
      lib: packing: use BITS_PER_BYTE instead of 8
      lib: packing: use GENMASK() for box_mask
      lib: packing: catch kunit_kzalloc() failure in the pack() test

Xingquan Liu (1):
      staging: rtl8712: remove parentheses after &

Yochai Hagvi (1):
      ice: Read SDP section from NVM for pin definitions

Zijun Hu (1):
      net: qcom/emac: Find sgmii_ops by device_for_each_child()

zhang jiao (1):
      selftests/net: Add missing va_end.

 Documentation/core-api/packing.rst                 |   71 +
 .../devicetree/bindings/net/dsa/realtek.yaml       |   46 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   21 +
 Documentation/devicetree/bindings/net/fsl,fec.yaml |    7 +
 .../devicetree/bindings/net/marvell,aquantia.yaml  |    6 +
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    9 +
 Documentation/netlink/specs/rt_link.yaml           |    4 +
 Documentation/networking/diagnostic/index.rst      |   17 +
 .../diagnostic/twisted_pair_layer1_diagnostics.rst |  767 ++++
 Documentation/networking/index.rst                 |    1 +
 .../networking/net_cachelines/net_device.rst       |    3 +-
 Documentation/networking/timestamping.rst          |   14 +
 MAINTAINERS                                        |   34 +-
 arch/alpha/include/uapi/asm/socket.h               |    2 +
 arch/mips/include/uapi/asm/socket.h                |    2 +
 arch/parisc/include/uapi/asm/socket.h              |    2 +
 arch/sparc/include/uapi/asm/socket.h               |    2 +
 drivers/net/dsa/b53/b53_mmap.c                     |    2 +-
 drivers/net/dsa/b53/b53_srab.c                     |    2 +-
 drivers/net/dsa/bcm_sf2.c                          |   11 +-
 drivers/net/dsa/bcm_sf2.h                          |    1 +
 drivers/net/dsa/hirschmann/hellcreek.c             |    2 +-
 drivers/net/dsa/lantiq_gswip.c                     |    2 +-
 drivers/net/dsa/mt7530-mmio.c                      |    2 +-
 drivers/net/dsa/mv88e6xxx/Kconfig                  |   10 +
 drivers/net/dsa/mv88e6xxx/Makefile                 |    1 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   73 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   16 +-
 drivers/net/dsa/mv88e6xxx/devlink.c                |    9 +-
 drivers/net/dsa/mv88e6xxx/global1_vtu.c            |    3 +
 drivers/net/dsa/mv88e6xxx/leds.c                   |  839 ++++
 drivers/net/dsa/mv88e6xxx/port.c                   |    1 +
 drivers/net/dsa/mv88e6xxx/port.h                   |  133 +
 drivers/net/dsa/ocelot/ocelot_ext.c                |    2 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c           |    2 +-
 drivers/net/dsa/realtek/realtek-mdio.c             |    2 +-
 drivers/net/dsa/realtek/realtek-smi.c              |    2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |    2 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |    2 +-
 drivers/net/dsa/rzn1_a5psw.c                       |    2 +-
 drivers/net/dsa/sja1105/sja1105.h                  |    2 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |   85 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |   28 +-
 drivers/net/dsa/vitesse-vsc73xx-platform.c         |    2 +-
 drivers/net/ethernet/8390/ax88796.c                |    2 +-
 drivers/net/ethernet/8390/mcf8390.c                |    2 +-
 drivers/net/ethernet/8390/ne.c                     |    2 +-
 drivers/net/ethernet/actions/owl-emac.c            |    2 +-
 drivers/net/ethernet/aeroflex/greth.c              |    2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c        |    2 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |    2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   40 +-
 drivers/net/ethernet/amd/au1000_eth.c              |    2 +-
 drivers/net/ethernet/amd/sunlance.c                |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c      |    2 +-
 drivers/net/ethernet/apm/xgene-v2/main.c           |    2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |    2 +-
 drivers/net/ethernet/apple/macmace.c               |    2 +-
 drivers/net/ethernet/arc/emac_rockchip.c           |    2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |   37 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |    2 +-
 drivers/net/ethernet/broadcom/bcm4908_enet.c       |    2 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |    4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |    2 +-
 drivers/net/ethernet/broadcom/bgmac-platform.c     |    2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    2 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c         |    2 +-
 drivers/net/ethernet/cadence/macb_main.c           |    5 +-
 drivers/net/ethernet/calxeda/xgmac.c               |    2 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c      |    4 +-
 .../ethernet/chelsio/inline_crypto/chtls/chtls.h   |    1 -
 .../chelsio/inline_crypto/chtls/chtls_hw.c         |    9 -
 drivers/net/ethernet/cirrus/cs89x0.c               |    2 +-
 drivers/net/ethernet/cirrus/ep93xx_eth.c           |    2 +-
 drivers/net/ethernet/cirrus/mac89x0.c              |    2 +-
 drivers/net/ethernet/cortina/gemini.c              |    4 +-
 drivers/net/ethernet/davicom/dm9000.c              |    2 +-
 drivers/net/ethernet/dnet.c                        |    2 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |    2 +-
 drivers/net/ethernet/ethoc.c                       |    2 +-
 drivers/net/ethernet/ezchip/nps_enet.c             |    2 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |    2 +-
 drivers/net/ethernet/faraday/ftmac100.c            |    2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |    2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c       |    2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c   |    2 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   11 +-
 drivers/net/ethernet/freescale/fman/fman_port.c    |    2 +-
 drivers/net/ethernet/freescale/fman/mac.c          |    2 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |    2 +-
 .../net/ethernet/freescale/fs_enet/mii-bitbang.c   |    2 +-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c   |    2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |    2 +-
 drivers/net/ethernet/freescale/gianfar.c           |    2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |    2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   17 +
 drivers/net/ethernet/google/gve/gve_utils.c        |    1 +
 drivers/net/ethernet/hisilicon/hip04_eth.c         |    2 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |    2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |   10 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    2 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |    2 +-
 drivers/net/ethernet/i825xx/sni_82596.c            |    2 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |    2 +-
 drivers/net/ethernet/ibm/emac/core.c               |    2 +-
 drivers/net/ethernet/ibm/emac/mal.c                |    2 +-
 drivers/net/ethernet/ibm/emac/rgmii.c              |    2 +-
 drivers/net/ethernet/ibm/emac/tah.c                |    2 +-
 drivers/net/ethernet/ibm/emac/zmii.c               |    2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   23 +-
 drivers/net/ethernet/ibm/ibmvnic.h                 |    3 +-
 drivers/net/ethernet/intel/ice/ice.h               |    5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c       |   22 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h       |   22 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |    9 +
 drivers/net/ethernet/intel/ice/ice_gnss.c          |    4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 1521 +++----
 drivers/net/ethernet/intel/ice/ice_ptp.h           |  143 +-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  125 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   73 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    3 +-
 drivers/net/ethernet/korina.c                      |    2 +-
 drivers/net/ethernet/lantiq_etop.c                 |    2 +-
 drivers/net/ethernet/lantiq_xrx200.c               |    2 +-
 drivers/net/ethernet/litex/litex_liteeth.c         |    2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   32 +-
 drivers/net/ethernet/marvell/mvmdio.c              |   13 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 +-
 drivers/net/ethernet/marvell/mvneta_bm.c           |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    2 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   14 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |    2 +-
 drivers/net/ethernet/mediatek/airoha_eth.c         |   22 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |    2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |  393 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |    2 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |    6 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h   |    2 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |   66 +-
 drivers/net/ethernet/micrel/ks8842.c               |    2 +-
 drivers/net/ethernet/micrel/ks8851_par.c           |    2 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |    2 +-
 drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |   56 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_dcb.c |    5 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   34 +-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   10 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |   10 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  230 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  128 +-
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 4459 ++++++++++--------
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |   15 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |    8 +-
 .../net/ethernet/microchip/sparx5/sparx5_pgid.c    |   15 +-
 .../net/ethernet/microchip/sparx5/sparx5_police.c  |    3 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   76 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   23 +-
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    |   49 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   44 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |    8 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |    2 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  219 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  244 +
 .../net/ethernet/microchip/sparx5/sparx5_sdlb.c    |   15 +-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |   33 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |    8 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |    4 +-
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |   47 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   11 +
 drivers/net/ethernet/moxa/moxart_ether.c           |    2 +-
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |    2 +-
 drivers/net/ethernet/natsemi/jazzsonic.c           |    2 +-
 drivers/net/ethernet/natsemi/macsonic.c            |    2 +-
 drivers/net/ethernet/natsemi/xtsonic.c             |    2 +-
 drivers/net/ethernet/ni/nixge.c                    |    2 +-
 drivers/net/ethernet/nxp/lpc_eth.c                 |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c        |    1 +
 drivers/net/ethernet/qlogic/qed/qed_hw.c           |    1 +
 drivers/net/ethernet/qlogic/qed/qed_mcp.c          |   45 +-
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c    |   22 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |    2 +-
 drivers/net/ethernet/renesas/ravb_main.c           |    2 +-
 drivers/net/ethernet/renesas/rswitch.c             |    2 +-
 drivers/net/ethernet/renesas/sh_eth.c              |    2 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c    |    2 +-
 drivers/net/ethernet/seeq/sgiseeq.c                |    2 +-
 drivers/net/ethernet/sfc/ef100_rx.c                |    5 +-
 drivers/net/ethernet/sfc/efx.c                     |  109 +
 drivers/net/ethernet/sfc/efx_channels.c            |    6 +
 drivers/net/ethernet/sfc/efx_channels.h            |    7 +
 drivers/net/ethernet/sfc/ethtool_common.c          |    3 +-
 drivers/net/ethernet/sfc/net_driver.h              |   47 +-
 drivers/net/ethernet/sfc/rx.c                      |    5 +-
 drivers/net/ethernet/sfc/rx_common.c               |    3 +
 drivers/net/ethernet/sfc/tx.c                      |    6 +-
 drivers/net/ethernet/sfc/tx_common.c               |   33 +-
 drivers/net/ethernet/sfc/tx_common.h               |    4 +-
 drivers/net/ethernet/sgi/ioc3-eth.c                |    2 +-
 drivers/net/ethernet/sgi/meth.c                    |    2 +-
 drivers/net/ethernet/smsc/smc91x.c                 |    2 +-
 drivers/net/ethernet/smsc/smsc911x.c               |    2 +-
 drivers/net/ethernet/socionext/netsec.c            |    2 +-
 drivers/net/ethernet/socionext/sni_ave.c           |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |    2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |    7 +-
 drivers/net/ethernet/sun/niu.c                     |    2 +-
 drivers/net/ethernet/sun/sunbmac.c                 |    2 +-
 drivers/net/ethernet/sun/sunqe.c                   |    2 +-
 drivers/net/ethernet/sunplus/spl2sw_driver.c       |    2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    2 +-
 drivers/net/ethernet/ti/cpsw.c                     |    2 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |    2 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |    2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |    2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |    2 +-
 drivers/net/ethernet/ti/netcp_core.c               |    2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |    1 -
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.h  |    1 -
 drivers/net/ethernet/tundra/tsi108_eth.c           |    2 +-
 drivers/net/ethernet/via/via-rhine.c               |    2 +-
 drivers/net/ethernet/via/via-velocity.c            |    2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   18 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |    2 +-
 drivers/net/ethernet/wiznet/w5100.c                |    2 +-
 drivers/net/ethernet/wiznet/w5300.c                |    2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    2 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |    2 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |    2 +-
 drivers/net/fjes/fjes_main.c                       |    2 +-
 drivers/net/hyperv/netvsc.c                        |   13 +-
 drivers/net/hyperv/netvsc_drv.c                    |    2 +-
 drivers/net/hyperv/rndis_filter.c                  |    9 +-
 drivers/net/ieee802154/fakelb.c                    |    2 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |    2 +-
 drivers/net/ipa/ipa_main.c                         |    2 +-
 drivers/net/ipvlan/ipvlan_l3s.c                    |    6 +-
 drivers/net/mdio/mdio-aspeed.c                     |    2 +-
 drivers/net/mdio/mdio-bcm-iproc.c                  |    2 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |    2 +-
 drivers/net/mdio/mdio-gpio.c                       |    2 +-
 drivers/net/mdio/mdio-hisi-femac.c                 |    2 +-
 drivers/net/mdio/mdio-ipq4019.c                    |    2 +-
 drivers/net/mdio/mdio-ipq8064.c                    |    2 +-
 drivers/net/mdio/mdio-moxart.c                     |    2 +-
 drivers/net/mdio/mdio-mscc-miim.c                  |    2 +-
 drivers/net/mdio/mdio-mux-bcm-iproc.c              |    2 +-
 drivers/net/mdio/mdio-mux-bcm6368.c                |    2 +-
 drivers/net/mdio/mdio-mux-gpio.c                   |    2 +-
 drivers/net/mdio/mdio-mux-meson-g12a.c             |    2 +-
 drivers/net/mdio/mdio-mux-meson-gxl.c              |    2 +-
 drivers/net/mdio/mdio-mux-mmioreg.c                |    2 +-
 drivers/net/mdio/mdio-mux-multiplexer.c            |    2 +-
 drivers/net/mdio/mdio-octeon.c                     |    2 +-
 drivers/net/mdio/mdio-sun4i.c                      |    2 +-
 drivers/net/mdio/mdio-thunder.c                    |    4 +-
 drivers/net/mdio/mdio-xgene.c                      |    2 +-
 drivers/net/pcs/pcs-rzn1-miic.c                    |    2 +-
 drivers/net/pcs/pcs-xpcs.c                         |   92 +-
 drivers/net/phy/aquantia/aquantia_main.c           |   33 +
 drivers/net/phy/marvell-88q2xxx.c                  |  124 +-
 drivers/net/phy/microchip_t1.c                     |  232 +
 drivers/net/phy/mxl-gpy.c                          |  219 +
 drivers/net/phy/phy-core.c                         |   33 +
 drivers/net/phy/phy_device.c                       |    3 +
 drivers/net/phy/sfp.c                              |    2 +-
 drivers/net/phy/smsc.c                             |    5 +-
 drivers/net/tun.c                                  |    2 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    8 +
 drivers/net/wan/framer/pef2256/pef2256.c           |    2 +-
 drivers/net/wan/fsl_qmc_hdlc.c                     |    2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |    2 +-
 drivers/net/wan/ixp4xx_hss.c                       |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |   27 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |    9 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   55 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   22 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    3 +
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |    2 +
 drivers/net/wireless/intel/ipw2x00/Kconfig         |   10 -
 drivers/net/wireless/intel/ipw2x00/Makefile        |    7 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |    9 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.h       |    2 -
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   25 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.h       |    4 -
 drivers/net/wireless/intel/ipw2x00/libipw.h        |  114 +-
 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c |  246 +
 .../wireless/intel/ipw2x00/libipw_crypto_ccmp.c    |   76 +-
 .../wireless/intel/ipw2x00/libipw_crypto_tkip.c    |  106 +-
 .../net/wireless/intel/ipw2x00/libipw_crypto_wep.c |   73 +-
 drivers/net/wireless/intel/ipw2x00/libipw_module.c |   36 +-
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |   11 +-
 .../net/wireless/intel/ipw2x00/libipw_spy.c        |   63 +-
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c     |    4 +-
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c     |   43 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |    4 +-
 drivers/net/wireless/marvell/libertas/Kconfig      |    1 -
 drivers/net/wireless/marvell/libertas/mesh.h       |    1 -
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |    2 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    1 -
 drivers/net/wireless/quantenna/qtnfmac/core.h      |    1 -
 drivers/net/wireless/ti/wl1251/sdio.c              |    4 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   13 +-
 drivers/net/wwan/qcom_bam_dmux.c                   |    2 +-
 drivers/staging/Kconfig                            |   18 +-
 drivers/staging/Makefile                           |    9 +-
 drivers/staging/axis-fifo/axis-fifo.c              |    2 +-
 drivers/staging/fbtft/fbtft.h                      |    2 +-
 .../fieldbus/Documentation/ABI/fieldbus-dev-cdev   |   31 -
 .../Documentation/ABI/sysfs-class-fieldbus-dev     |   62 -
 .../bindings/fieldbus/arcx,anybus-controller.txt   |   71 -
 .../fieldbus/Documentation/fieldbus_dev.txt        |   66 -
 drivers/staging/fieldbus/Kconfig                   |   19 -
 drivers/staging/fieldbus/Makefile                  |    7 -
 drivers/staging/fieldbus/TODO                      |    5 -
 drivers/staging/fieldbus/anybuss/Kconfig           |   41 -
 drivers/staging/fieldbus/anybuss/Makefile          |   10 -
 drivers/staging/fieldbus/anybuss/anybuss-client.h  |   95 -
 .../staging/fieldbus/anybuss/anybuss-controller.h  |   47 -
 drivers/staging/fieldbus/anybuss/arcx-anybus.c     |  379 --
 drivers/staging/fieldbus/anybuss/hms-profinet.c    |  224 -
 drivers/staging/fieldbus/anybuss/host.c            | 1452 ------
 drivers/staging/fieldbus/dev_core.c                |  344 --
 drivers/staging/fieldbus/fieldbus_dev.h            |  114 -
 drivers/staging/gdm724x/Kconfig                    |   16 -
 drivers/staging/gdm724x/Makefile                   |    8 -
 drivers/staging/gdm724x/TODO                       |   16 -
 drivers/staging/gdm724x/gdm_endian.c               |   37 -
 drivers/staging/gdm724x/gdm_endian.h               |   30 -
 drivers/staging/gdm724x/gdm_lte.c                  |  937 ----
 drivers/staging/gdm724x/gdm_lte.h                  |   71 -
 drivers/staging/gdm724x/gdm_mux.c                  |  668 ---
 drivers/staging/gdm724x/gdm_mux.h                  |   85 -
 drivers/staging/gdm724x/gdm_tty.c                  |  316 --
 drivers/staging/gdm724x/gdm_tty.h                  |   60 -
 drivers/staging/gdm724x/gdm_usb.c                  | 1012 -----
 drivers/staging/gdm724x/gdm_usb.h                  |   99 -
 drivers/staging/gdm724x/hci.h                      |   45 -
 drivers/staging/gdm724x/hci_packet.h               |   82 -
 drivers/staging/gdm724x/netlink_k.c                |  128 -
 drivers/staging/gdm724x/netlink_k.h                |   16 -
 drivers/staging/gpib/Kconfig                       |  251 ++
 drivers/staging/gpib/Makefile                      |   20 +
 drivers/staging/gpib/TODO                          |   21 +
 drivers/staging/gpib/agilent_82350b/Makefile       |    2 +
 .../staging/gpib/agilent_82350b/agilent_82350b.c   |  932 ++++
 .../staging/gpib/agilent_82350b/agilent_82350b.h   |  209 +
 drivers/staging/gpib/agilent_82357a/Makefile       |    4 +
 .../staging/gpib/agilent_82357a/agilent_82357a.c   | 1712 +++++++
 .../staging/gpib/agilent_82357a/agilent_82357a.h   |  182 +
 drivers/staging/gpib/cb7210/Makefile               |    4 +
 drivers/staging/gpib/cb7210/cb7210.c               | 1556 +++++++
 drivers/staging/gpib/cb7210/cb7210.h               |  251 ++
 drivers/staging/gpib/cec/Makefile                  |    3 +
 drivers/staging/gpib/cec/cec.h                     |   53 +
 drivers/staging/gpib/cec/cec_gpib.c                |  385 ++
 drivers/staging/gpib/common/Makefile               |    6 +
 drivers/staging/gpib/common/gpib_os.c              | 2328 ++++++++++
 drivers/staging/gpib/common/iblib.c                |  740 +++
 drivers/staging/gpib/common/ibsys.h                |   31 +
 drivers/staging/gpib/eastwood/Makefile             |    3 +
 drivers/staging/gpib/eastwood/fluke_gpib.c         | 1179 +++++
 drivers/staging/gpib/eastwood/fluke_gpib.h         |  143 +
 drivers/staging/gpib/fmh_gpib/Makefile             |    2 +
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c           | 1725 +++++++
 drivers/staging/gpib/fmh_gpib/fmh_gpib.h           |  177 +
 drivers/staging/gpib/gpio/Makefile                 |    4 +
 drivers/staging/gpib/gpio/gpib_bitbang.c           | 1476 ++++++
 drivers/staging/gpib/hp_82335/Makefile             |    4 +
 drivers/staging/gpib/hp_82335/hp82335.c            |  360 ++
 drivers/staging/gpib/hp_82335/hp82335.h            |   85 +
 drivers/staging/gpib/hp_82341/Makefile             |    2 +
 drivers/staging/gpib/hp_82341/hp_82341.c           |  895 ++++
 drivers/staging/gpib/hp_82341/hp_82341.h           |  207 +
 drivers/staging/gpib/include/amcc5920.h            |   49 +
 drivers/staging/gpib/include/amccs5933.h           |   59 +
 drivers/staging/gpib/include/gpibP.h               |   50 +
 drivers/staging/gpib/include/gpib_pci_ids.h        |   23 +
 drivers/staging/gpib/include/gpib_proto.h          |   56 +
 drivers/staging/gpib/include/gpib_state_machines.h |   23 +
 drivers/staging/gpib/include/gpib_types.h          |  353 ++
 drivers/staging/gpib/include/nec7210.h             |  138 +
 drivers/staging/gpib/include/nec7210_registers.h   |  217 +
 drivers/staging/gpib/include/plx9050.h             |   72 +
 drivers/staging/gpib/include/quancom_pci.h         |   22 +
 drivers/staging/gpib/include/tms9914.h             |  274 ++
 drivers/staging/gpib/include/tnt4882_registers.h   |  192 +
 drivers/staging/gpib/ines/Makefile                 |    4 +
 drivers/staging/gpib/ines/ines.h                   |  215 +
 drivers/staging/gpib/ines/ines_gpib.c              | 1464 ++++++
 drivers/staging/gpib/lpvo_usb_gpib/Makefile        |    3 +
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2136 +++++++++
 drivers/staging/gpib/nec7210/Makefile              |    4 +
 drivers/staging/gpib/nec7210/board.h               |   19 +
 drivers/staging/gpib/nec7210/nec7210.c             | 1134 +++++
 drivers/staging/gpib/ni_usb/Makefile               |    4 +
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c          | 2640 +++++++++++
 drivers/staging/gpib/ni_usb/ni_usb_gpib.h          |  216 +
 drivers/staging/gpib/pc2/Makefile                  |    5 +
 drivers/staging/gpib/pc2/pc2_gpib.c                |  656 +++
 drivers/staging/gpib/tms9914/Makefile              |    6 +
 drivers/staging/gpib/tms9914/tms9914.c             |  910 ++++
 drivers/staging/gpib/tnt4882/Makefile              |    7 +
 drivers/staging/gpib/tnt4882/mite.c                |  219 +
 drivers/staging/gpib/tnt4882/mite.h                |  243 +
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c        | 1874 ++++++++
 drivers/staging/gpib/uapi/gpib_ioctl.h             |  169 +
 drivers/staging/gpib/uapi/gpib_user.h              |  363 ++
 drivers/staging/greybus/arche-apb-ctrl.c           |    2 +-
 drivers/staging/greybus/arche-platform.c           |    2 +-
 drivers/staging/greybus/gpio.c                     |   33 +-
 drivers/staging/greybus/uart.c                     |    2 +
 drivers/staging/iio/TODO                           |    5 -
 .../media/deprecated/atmel/atmel-sama5d2-isc.c     |    2 +-
 .../media/deprecated/atmel/atmel-sama7g5-isc.c     |    2 +-
 drivers/staging/media/imx/imx-media-csi.c          |    2 +-
 drivers/staging/media/imx/imx-media-dev.c          |    2 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c         |    2 +-
 drivers/staging/media/meson/vdec/vdec.c            |    2 +-
 drivers/staging/media/omap4iss/iss.c               |    2 +-
 drivers/staging/media/rkvdec/rkvdec.c              |    2 +-
 drivers/staging/media/starfive/camss/stf-camss.c   |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    2 +-
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |    2 +-
 drivers/staging/media/tegra-video/csi.c            |    2 +-
 drivers/staging/media/tegra-video/vi.c             |    2 +-
 drivers/staging/media/tegra-video/vip.c            |    2 +-
 drivers/staging/most/TODO                          |    7 -
 drivers/staging/most/dim2/dim2.c                   |    2 +-
 drivers/staging/most/i2c/i2c.c                     |    4 +-
 drivers/staging/nvec/nvec.c                        |    2 +-
 drivers/staging/nvec/nvec_kbd.c                    |    2 +-
 drivers/staging/nvec/nvec_power.c                  |    2 +-
 drivers/staging/nvec/nvec_ps2.c                    |    2 +-
 drivers/staging/octeon/ethernet-tx.c               |    6 +-
 drivers/staging/octeon/ethernet.c                  |    2 +-
 drivers/staging/olpc_dcon/Kconfig                  |   17 -
 drivers/staging/olpc_dcon/Makefile                 |    5 -
 drivers/staging/olpc_dcon/TODO                     |   15 -
 drivers/staging/olpc_dcon/olpc_dcon.c              |  807 ----
 drivers/staging/olpc_dcon/olpc_dcon.h              |  112 -
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c         |  201 -
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c       |  204 -
 drivers/staging/rtl8192e/Kconfig                   |   61 -
 drivers/staging/rtl8192e/Makefile                  |   19 -
 drivers/staging/rtl8192e/TODO                      |   18 -
 drivers/staging/rtl8192e/rtl8192e/Kconfig          |   10 -
 drivers/staging/rtl8192e/rtl8192e/Makefile         |   19 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |  266 --
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  198 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h |   17 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |   79 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h  |   12 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     | 1915 --------
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h     |   34 -
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c    |  189 -
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.h    |   52 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      |  244 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     | 1110 -----
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     |   55 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h  |  773 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |  123 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h        |   25 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       | 2016 ---------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |  402 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 1856 --------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |  155 -
 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c     |   84 -
 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h     |   12 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c    |   37 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c        |   79 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h        |   20 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c         |   89 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h         |   16 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |  230 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h         |   31 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  867 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h         |   13 -
 drivers/staging/rtl8192e/rtl8192e/table.c          |  543 ---
 drivers/staging/rtl8192e/rtl8192e/table.h          |   27 -
 drivers/staging/rtl8192e/rtl819x_BA.h              |   60 -
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |  544 ---
 drivers/staging/rtl8192e/rtl819x_HT.h              |  223 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |  699 ---
 drivers/staging/rtl8192e/rtl819x_Qos.h             |   43 -
 drivers/staging/rtl8192e/rtl819x_TS.h              |   50 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |  450 --
 drivers/staging/rtl8192e/rtllib.h                  | 1799 --------
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |  411 --
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |  706 ---
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |  242 -
 drivers/staging/rtl8192e/rtllib_module.c           |  179 -
 drivers/staging/rtl8192e/rtllib_rx.c               | 2564 -----------
 drivers/staging/rtl8192e/rtllib_softmac.c          | 2309 ----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |  534 ---
 drivers/staging/rtl8192e/rtllib_tx.c               |  901 ----
 drivers/staging/rtl8192e/rtllib_wx.c               |  752 ----
 drivers/staging/rtl8712/Kconfig                    |   21 -
 drivers/staging/rtl8712/Makefile                   |   35 -
 drivers/staging/rtl8712/TODO                       |   13 -
 drivers/staging/rtl8712/basic_types.h              |   28 -
 drivers/staging/rtl8712/drv_types.h                |  175 -
 drivers/staging/rtl8712/ethernet.h                 |   21 -
 drivers/staging/rtl8712/hal_init.c                 |  401 --
 drivers/staging/rtl8712/ieee80211.c                |  415 --
 drivers/staging/rtl8712/ieee80211.h                |  165 -
 drivers/staging/rtl8712/mlme_linux.c               |  160 -
 drivers/staging/rtl8712/mlme_osdep.h               |   31 -
 drivers/staging/rtl8712/mp_custom_oid.h            |  287 --
 drivers/staging/rtl8712/os_intfs.c                 |  482 --
 drivers/staging/rtl8712/osdep_intf.h               |   32 -
 drivers/staging/rtl8712/osdep_service.h            |   60 -
 drivers/staging/rtl8712/recv_linux.c               |  139 -
 drivers/staging/rtl8712/recv_osdep.h               |   39 -
 drivers/staging/rtl8712/rtl8712_bitdef.h           |   26 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |  409 --
 drivers/staging/rtl8712/rtl8712_cmd.h              |  231 -
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h   |   95 -
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h   |   19 -
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h |   41 -
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h |   32 -
 .../staging/rtl8712/rtl8712_edcasetting_bitdef.h   |   65 -
 .../staging/rtl8712/rtl8712_edcasetting_regdef.h   |   24 -
 drivers/staging/rtl8712/rtl8712_efuse.c            |  563 ---
 drivers/staging/rtl8712/rtl8712_efuse.h            |   44 -
 drivers/staging/rtl8712/rtl8712_event.h            |   86 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h  |  131 -
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h  |   61 -
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h        |   68 -
 drivers/staging/rtl8712/rtl8712_gp_regdef.h        |   29 -
 drivers/staging/rtl8712/rtl8712_hal.h              |  142 -
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h |   44 -
 drivers/staging/rtl8712/rtl8712_io.c               |   99 -
 drivers/staging/rtl8712/rtl8712_led.c              | 1830 --------
 .../staging/rtl8712/rtl8712_macsetting_bitdef.h    |   31 -
 .../staging/rtl8712/rtl8712_macsetting_regdef.h    |   20 -
 drivers/staging/rtl8712/rtl8712_powersave_bitdef.h |   39 -
 drivers/staging/rtl8712/rtl8712_powersave_regdef.h |   26 -
 drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h  |   36 -
 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h  |   43 -
 drivers/staging/rtl8712/rtl8712_recv.c             | 1075 -----
 drivers/staging/rtl8712/rtl8712_recv.h             |  145 -
 drivers/staging/rtl8712/rtl8712_regdef.h           |   32 -
 drivers/staging/rtl8712/rtl8712_security_bitdef.h  |   34 -
 drivers/staging/rtl8712/rtl8712_spec.h             |  121 -
 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h    |  163 -
 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h    |   42 -
 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h  |   49 -
 drivers/staging/rtl8712/rtl8712_timectrl_regdef.h  |   26 -
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h      |   49 -
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h      |   36 -
 drivers/staging/rtl8712/rtl8712_xmit.c             |  732 ---
 drivers/staging/rtl8712/rtl8712_xmit.h             |  108 -
 drivers/staging/rtl8712/rtl871x_cmd.c              |  750 ----
 drivers/staging/rtl8712/rtl871x_cmd.h              |  750 ----
 drivers/staging/rtl8712/rtl871x_debug.h            |  130 -
 drivers/staging/rtl8712/rtl871x_eeprom.c           |  220 -
 drivers/staging/rtl8712/rtl871x_eeprom.h           |   88 -
 drivers/staging/rtl8712/rtl871x_event.h            |  109 -
 drivers/staging/rtl8712/rtl871x_ht.h               |   33 -
 drivers/staging/rtl8712/rtl871x_io.c               |  147 -
 drivers/staging/rtl8712/rtl871x_io.h               |  236 -
 drivers/staging/rtl8712/rtl871x_ioctl.h            |   94 -
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c      | 2275 ----------
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c        |  519 ---
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h        |  109 -
 drivers/staging/rtl8712/rtl871x_ioctl_set.c        |  354 --
 drivers/staging/rtl8712/rtl871x_ioctl_set.h        |   45 -
 drivers/staging/rtl8712/rtl871x_led.h              |  118 -
 drivers/staging/rtl8712/rtl871x_mlme.c             | 1710 -------
 drivers/staging/rtl8712/rtl871x_mlme.h             |  205 -
 drivers/staging/rtl8712/rtl871x_mp.c               |  724 ---
 drivers/staging/rtl8712/rtl871x_mp.h               |  275 --
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c         |  883 ----
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h         |  328 --
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h    | 1034 -----
 drivers/staging/rtl8712/rtl871x_pwrctrl.c          |  234 -
 drivers/staging/rtl8712/rtl871x_pwrctrl.h          |  113 -
 drivers/staging/rtl8712/rtl871x_recv.c             |  671 ---
 drivers/staging/rtl8712/rtl871x_recv.h             |  208 -
 drivers/staging/rtl8712/rtl871x_rf.h               |   55 -
 drivers/staging/rtl8712/rtl871x_security.c         | 1386 ------
 drivers/staging/rtl8712/rtl871x_security.h         |  218 -
 drivers/staging/rtl8712/rtl871x_sta_mgt.c          |  263 --
 drivers/staging/rtl8712/rtl871x_wlan_sme.h         |   35 -
 drivers/staging/rtl8712/rtl871x_xmit.c             | 1056 -----
 drivers/staging/rtl8712/rtl871x_xmit.h             |  287 --
 drivers/staging/rtl8712/sta_info.h                 |  132 -
 drivers/staging/rtl8712/usb_halinit.c              |  307 --
 drivers/staging/rtl8712/usb_intf.c                 |  638 ---
 drivers/staging/rtl8712/usb_ops.c                  |  195 -
 drivers/staging/rtl8712/usb_ops.h                  |   38 -
 drivers/staging/rtl8712/usb_ops_linux.c            |  508 ---
 drivers/staging/rtl8712/usb_osintf.h               |   35 -
 drivers/staging/rtl8712/wifi.h                     |  196 -
 drivers/staging/rtl8712/wlan_bssdef.h              |  223 -
 drivers/staging/rtl8712/xmit_linux.c               |  181 -
 drivers/staging/rtl8712/xmit_osdep.h               |   52 -
 drivers/staging/rtl8723bs/TODO                     |    4 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |    6 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   94 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |    6 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   11 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |    7 -
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |   68 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |    2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c            |   42 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c           |  137 +-
 drivers/staging/rtl8723bs/hal/odm.c                |   14 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  550 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |   15 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |    4 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |   59 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |   10 -
 drivers/staging/rtl8723bs/include/hal_com.h        |    4 -
 drivers/staging/rtl8723bs/include/hal_intf.h       |   95 +-
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h    |    5 -
 drivers/staging/rtl8723bs/include/osdep_intf.h     |    3 -
 drivers/staging/rtl8723bs/include/osdep_service.h  |    5 -
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h  |    5 +
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |    2 +
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |    4 -
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |    5 -
 drivers/staging/rtl8723bs/include/rtw_mp.h         |    4 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   12 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   17 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |   31 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |   17 +-
 drivers/staging/rts5208/Kconfig                    |    9 -
 drivers/staging/rts5208/Makefile                   |    5 -
 drivers/staging/rts5208/TODO                       |    7 -
 drivers/staging/rts5208/general.c                  |   25 -
 drivers/staging/rts5208/general.h                  |   19 -
 drivers/staging/rts5208/ms.c                       | 4311 ------------------
 drivers/staging/rts5208/ms.h                       |  214 -
 drivers/staging/rts5208/rtsx.c                     |  987 ----
 drivers/staging/rts5208/rtsx.h                     |  164 -
 drivers/staging/rts5208/rtsx_card.c                | 1151 -----
 drivers/staging/rts5208/rtsx_card.h                | 1087 -----
 drivers/staging/rts5208/rtsx_chip.c                | 2161 ---------
 drivers/staging/rts5208/rtsx_chip.h                |  987 ----
 drivers/staging/rts5208/rtsx_scsi.c                | 3279 --------------
 drivers/staging/rts5208/rtsx_scsi.h                |  131 -
 drivers/staging/rts5208/rtsx_sys.h                 |   36 -
 drivers/staging/rts5208/rtsx_transport.c           |  768 ----
 drivers/staging/rts5208/rtsx_transport.h           |   57 -
 drivers/staging/rts5208/sd.c                       | 4717 --------------------
 drivers/staging/rts5208/sd.h                       |  289 --
 drivers/staging/rts5208/spi.c                      |  906 ----
 drivers/staging/rts5208/spi.h                      |   52 -
 drivers/staging/rts5208/xd.c                       | 2145 ---------
 drivers/staging/rts5208/xd.h                       |  176 -
 drivers/staging/sm750fb/TODO                       |    5 -
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |    3 +-
 .../include/linux/raspberrypi/vchiq.h              |    7 +-
 drivers/staging/vc04_services/interface/TESTING    |    4 +-
 drivers/staging/vc04_services/interface/TODO       |   13 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  518 +--
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |    3 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  696 ++-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   55 +-
 .../interface/vchiq_arm/vchiq_debugfs.h            |    3 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   42 +-
 .../interface/vchiq_arm/vchiq_ioctl.h              |    2 +-
 .../interface/vchiq_arm/vchiq_pagelist.h           |   21 -
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |    7 +-
 drivers/staging/vme_user/vme_bridge.h              |   56 +-
 drivers/staging/vt6655/Kconfig                     |    6 -
 drivers/staging/vt6655/Makefile                    |   15 -
 drivers/staging/vt6655/TODO                        |   21 -
 drivers/staging/vt6655/baseband.c                  | 2257 ----------
 drivers/staging/vt6655/baseband.h                  |   72 -
 drivers/staging/vt6655/card.c                      |  836 ----
 drivers/staging/vt6655/card.h                      |   62 -
 drivers/staging/vt6655/channel.c                   |  135 -
 drivers/staging/vt6655/channel.h                   |   17 -
 drivers/staging/vt6655/desc.h                      |  249 --
 drivers/staging/vt6655/device.h                    |  292 --
 drivers/staging/vt6655/device_cfg.h                |   44 -
 drivers/staging/vt6655/device_main.c               | 1868 --------
 drivers/staging/vt6655/dpc.c                       |  145 -
 drivers/staging/vt6655/dpc.h                       |   21 -
 drivers/staging/vt6655/key.c                       |  143 -
 drivers/staging/vt6655/key.h                       |   51 -
 drivers/staging/vt6655/mac.c                       |  851 ----
 drivers/staging/vt6655/mac.h                       |  580 ---
 drivers/staging/vt6655/power.c                     |  144 -
 drivers/staging/vt6655/power.h                     |   29 -
 drivers/staging/vt6655/rf.c                        |  535 ---
 drivers/staging/vt6655/rf.h                        |   71 -
 drivers/staging/vt6655/rxtx.c                      | 1462 ------
 drivers/staging/vt6655/rxtx.h                      |  184 -
 drivers/staging/vt6655/srom.c                      |  139 -
 drivers/staging/vt6655/srom.h                      |   85 -
 drivers/staging/vt6655/test                        |    9 -
 drivers/staging/vt6656/Kconfig                     |    7 -
 drivers/staging/vt6656/Makefile                    |   15 -
 drivers/staging/vt6656/TODO                        |   18 -
 drivers/staging/vt6656/baseband.c                  |  455 --
 drivers/staging/vt6656/baseband.h                  |   75 -
 drivers/staging/vt6656/card.c                      |  456 --
 drivers/staging/vt6656/card.h                      |   44 -
 drivers/staging/vt6656/channel.c                   |   77 -
 drivers/staging/vt6656/channel.h                   |   21 -
 drivers/staging/vt6656/desc.h                      |   91 -
 drivers/staging/vt6656/device.h                    |  386 --
 drivers/staging/vt6656/key.c                       |  142 -
 drivers/staging/vt6656/key.h                       |   40 -
 drivers/staging/vt6656/mac.c                       |  183 -
 drivers/staging/vt6656/mac.h                       |  373 --
 drivers/staging/vt6656/main_usb.c                  | 1121 -----
 drivers/staging/vt6656/power.c                     |  112 -
 drivers/staging/vt6656/power.h                     |   23 -
 drivers/staging/vt6656/rf.c                        |  443 --
 drivers/staging/vt6656/rf.h                        |   46 -
 drivers/staging/vt6656/rxtx.c                      |  730 ---
 drivers/staging/vt6656/rxtx.h                      |  178 -
 drivers/staging/vt6656/usbpipe.c                   |  506 ---
 drivers/staging/vt6656/usbpipe.h                   |   67 -
 drivers/staging/vt6656/wcmd.c                      |  185 -
 drivers/staging/vt6656/wcmd.h                      |   48 -
 include/linux/if_ltalk.h                           |    8 -
 include/linux/mlx5/driver.h                        |   33 +-
 include/linux/mlx5/fs.h                            |    3 -
 include/linux/netdevice.h                          |    9 +-
 include/linux/packing.h                            |   32 +-
 include/linux/pcs/pcs-xpcs.h                       |   14 +-
 include/linux/phy.h                                |    1 +
 include/linux/rtnetlink.h                          |   69 +-
 include/linux/wireless.h                           |    5 +-
 include/net/caif/cfsrvl.h                          |    1 -
 include/net/dsa.h                                  |   15 -
 include/net/inet_connection_sock.h                 |    9 +-
 include/net/inet_sock.h                            |    4 +-
 include/net/ip.h                                   |    5 +
 include/net/iw_handler.h                           |   41 +-
 include/net/lib80211.h                             |  122 -
 include/net/mana/mana.h                            |    2 +-
 include/net/net_namespace.h                        |    4 +
 include/net/netns/core.h                           |    1 +
 include/net/route.h                                |    8 +-
 include/net/sock.h                                 |   36 +-
 include/net/tcp.h                                  |    2 +-
 include/uapi/asm-generic/socket.h                  |    2 +
 include/uapi/linux/if_link.h                       |    1 +
 include/uapi/linux/pkt_sched.h                     |    2 +
 lib/Kconfig                                        |   12 +
 lib/Makefile                                       |    1 +
 lib/packing.c                                      |  400 +-
 lib/packing_test.c                                 |  413 ++
 net/Kconfig.debug                                  |   15 +
 net/appletalk/Makefile                             |    2 +-
 net/appletalk/dev.c                                |   46 -
 net/bridge/br_netfilter_hooks.c                    |    8 +-
 net/caif/cfsrvl.c                                  |    6 -
 net/can/raw.c                                      |    2 +-
 net/core/Makefile                                  |    1 +
 net/core/lwt_bpf.c                                 |    5 +-
 net/core/net_namespace.c                           |    7 +
 net/core/rtnetlink.c                               |   74 +
 net/core/rtnl_net_debug.c                          |  131 +
 net/core/skbuff.c                                  |    2 +-
 net/core/sock.c                                    |   15 +-
 net/core/sysctl_net_core.c                         |   18 +-
 net/dsa/dsa.c                                      |    8 -
 net/dsa/port.c                                     |   34 +-
 net/ethtool/ioctl.c                                |    1 +
 net/ipv4/fib_semantics.c                           |   88 +-
 net/ipv4/icmp.c                                    |   19 +-
 net/ipv4/inet_connection_sock.c                    |    6 +-
 net/ipv4/inet_diag.c                               |   10 +-
 net/ipv4/ip_fragment.c                             |    4 +-
 net/ipv4/ip_input.c                                |    2 +-
 net/ipv4/ip_options.c                              |    3 +-
 net/ipv4/ip_output.c                               |   21 +-
 net/ipv4/raw.c                                     |    2 +-
 net/ipv4/route.c                                   |   32 +-
 net/ipv4/tcp.c                                     |    7 +-
 net/ipv4/tcp_ipv4.c                                |   10 +-
 net/ipv4/tcp_output.c                              |    7 +-
 net/ipv4/tcp_timer.c                               |   19 +-
 net/ipv4/xfrm4_input.c                             |    2 +-
 net/ipv4/xfrm4_protocol.c                          |    2 +-
 net/ipv6/ip6_output.c                              |   22 +-
 net/ipv6/ip6_tunnel.c                              |    4 +-
 net/ipv6/raw.c                                     |    2 +-
 net/ipv6/tcp_ipv6.c                                |   10 +-
 net/mac80211/agg-tx.c                              |    2 +-
 net/mac80211/chan.c                                |    4 +-
 net/mac80211/ieee80211_i.h                         |    6 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mesh_hwmp.c                           |    6 +-
 net/mac80211/mesh_pathtbl.c                        |   10 +-
 net/mac80211/mesh_plink.c                          |    2 +-
 net/mac80211/mesh_sync.c                           |    2 +-
 net/mac80211/rc80211_minstrel_ht.c                 |    2 +-
 net/mac80211/sta_info.h                            |    2 +-
 net/mac80211/tkip.c                                |    2 +-
 net/mac80211/tx.c                                  |    2 +-
 net/mac80211/util.c                                |    6 +-
 net/mac80211/vht.c                                 |    4 +-
 net/mptcp/protocol.c                               |    3 +-
 net/packet/af_packet.c                             |    6 +-
 net/rds/ib_rdma.c                                  |    4 -
 net/sched/sch_fq.c                                 |   33 +-
 net/socket.c                                       |    2 +-
 net/wireless/Kconfig                               |   45 +-
 net/wireless/Makefile                              |    5 -
 net/wireless/chan.c                                |    2 +-
 net/wireless/core.c                                |   64 +-
 net/wireless/lib80211.c                            |  257 --
 net/wireless/nl80211.c                             |    6 +-
 net/wireless/radiotap.c                            |    2 +-
 net/wireless/reg.c                                 |    2 +-
 net/wireless/scan.c                                |    2 -
 net/wireless/util.c                                |    2 +-
 net/wireless/wext-compat.c                         |   11 +-
 net/wireless/wext-compat.h                         |    6 -
 net/wireless/wext-core.c                           |    2 +-
 rust/kernel/net/phy.rs                             |   16 +-
 tools/include/uapi/asm-generic/socket.h            |    2 +
 tools/include/uapi/linux/if_link.h                 |    1 +
 tools/net/ynl/ynl-gen-c.py                         |   25 +-
 .../selftests/drivers/net/mlxsw/rtnetlink.sh       |   10 +-
 .../selftests/drivers/net/mlxsw/sch_red_core.sh    |   28 +-
 .../selftests/drivers/net/mlxsw/sch_red_ets.sh     |    8 +-
 tools/testing/selftests/net/ioam6.sh               | 1906 +++++---
 tools/testing/selftests/net/ioam6_parser.c         | 1107 +++--
 tools/testing/selftests/net/lib/csum.c             |   12 +-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |    1 +
 tools/testing/selftests/net/txtimestamp.c          |   44 +-
 tools/testing/selftests/net/txtimestamp.sh         |   12 +-
 tools/testing/selftests/ptp/testptp.c              |   62 +-
 862 files changed, 42011 insertions(+), 107756 deletions(-)
 create mode 100644 Documentation/networking/diagnostic/index.rst
 create mode 100644 Documentation/networking/diagnostic/twisted_pair_layer1_diagnostics.rst
 create mode 100644 drivers/net/dsa/mv88e6xxx/leds.c
 create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
 create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
 create mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
 rename net/wireless/lib80211_crypt_ccmp.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_ccmp.c (83%)
 rename net/wireless/lib80211_crypt_tkip.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c (87%)
 rename net/wireless/lib80211_crypt_wep.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_wep.c (72%)
 rename net/wireless/wext-spy.c => drivers/net/wireless/intel/ipw2x00/libipw_spy.c (81%)
 delete mode 100644 drivers/staging/fieldbus/Documentation/ABI/fieldbus-dev-cdev
 delete mode 100644 drivers/staging/fieldbus/Documentation/ABI/sysfs-class-fieldbus-dev
 delete mode 100644 drivers/staging/fieldbus/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
 delete mode 100644 drivers/staging/fieldbus/Documentation/fieldbus_dev.txt
 delete mode 100644 drivers/staging/fieldbus/Kconfig
 delete mode 100644 drivers/staging/fieldbus/Makefile
 delete mode 100644 drivers/staging/fieldbus/TODO
 delete mode 100644 drivers/staging/fieldbus/anybuss/Kconfig
 delete mode 100644 drivers/staging/fieldbus/anybuss/Makefile
 delete mode 100644 drivers/staging/fieldbus/anybuss/anybuss-client.h
 delete mode 100644 drivers/staging/fieldbus/anybuss/anybuss-controller.h
 delete mode 100644 drivers/staging/fieldbus/anybuss/arcx-anybus.c
 delete mode 100644 drivers/staging/fieldbus/anybuss/hms-profinet.c
 delete mode 100644 drivers/staging/fieldbus/anybuss/host.c
 delete mode 100644 drivers/staging/fieldbus/dev_core.c
 delete mode 100644 drivers/staging/fieldbus/fieldbus_dev.h
 delete mode 100644 drivers/staging/gdm724x/Kconfig
 delete mode 100644 drivers/staging/gdm724x/Makefile
 delete mode 100644 drivers/staging/gdm724x/TODO
 delete mode 100644 drivers/staging/gdm724x/gdm_endian.c
 delete mode 100644 drivers/staging/gdm724x/gdm_endian.h
 delete mode 100644 drivers/staging/gdm724x/gdm_lte.c
 delete mode 100644 drivers/staging/gdm724x/gdm_lte.h
 delete mode 100644 drivers/staging/gdm724x/gdm_mux.c
 delete mode 100644 drivers/staging/gdm724x/gdm_mux.h
 delete mode 100644 drivers/staging/gdm724x/gdm_tty.c
 delete mode 100644 drivers/staging/gdm724x/gdm_tty.h
 delete mode 100644 drivers/staging/gdm724x/gdm_usb.c
 delete mode 100644 drivers/staging/gdm724x/gdm_usb.h
 delete mode 100644 drivers/staging/gdm724x/hci.h
 delete mode 100644 drivers/staging/gdm724x/hci_packet.h
 delete mode 100644 drivers/staging/gdm724x/netlink_k.c
 delete mode 100644 drivers/staging/gdm724x/netlink_k.h
 create mode 100644 drivers/staging/gpib/Kconfig
 create mode 100644 drivers/staging/gpib/Makefile
 create mode 100644 drivers/staging/gpib/TODO
 create mode 100644 drivers/staging/gpib/agilent_82350b/Makefile
 create mode 100644 drivers/staging/gpib/agilent_82350b/agilent_82350b.c
 create mode 100644 drivers/staging/gpib/agilent_82350b/agilent_82350b.h
 create mode 100644 drivers/staging/gpib/agilent_82357a/Makefile
 create mode 100644 drivers/staging/gpib/agilent_82357a/agilent_82357a.c
 create mode 100644 drivers/staging/gpib/agilent_82357a/agilent_82357a.h
 create mode 100644 drivers/staging/gpib/cb7210/Makefile
 create mode 100644 drivers/staging/gpib/cb7210/cb7210.c
 create mode 100644 drivers/staging/gpib/cb7210/cb7210.h
 create mode 100644 drivers/staging/gpib/cec/Makefile
 create mode 100644 drivers/staging/gpib/cec/cec.h
 create mode 100644 drivers/staging/gpib/cec/cec_gpib.c
 create mode 100644 drivers/staging/gpib/common/Makefile
 create mode 100644 drivers/staging/gpib/common/gpib_os.c
 create mode 100644 drivers/staging/gpib/common/iblib.c
 create mode 100644 drivers/staging/gpib/common/ibsys.h
 create mode 100644 drivers/staging/gpib/eastwood/Makefile
 create mode 100644 drivers/staging/gpib/eastwood/fluke_gpib.c
 create mode 100644 drivers/staging/gpib/eastwood/fluke_gpib.h
 create mode 100644 drivers/staging/gpib/fmh_gpib/Makefile
 create mode 100644 drivers/staging/gpib/fmh_gpib/fmh_gpib.c
 create mode 100644 drivers/staging/gpib/fmh_gpib/fmh_gpib.h
 create mode 100644 drivers/staging/gpib/gpio/Makefile
 create mode 100644 drivers/staging/gpib/gpio/gpib_bitbang.c
 create mode 100644 drivers/staging/gpib/hp_82335/Makefile
 create mode 100644 drivers/staging/gpib/hp_82335/hp82335.c
 create mode 100644 drivers/staging/gpib/hp_82335/hp82335.h
 create mode 100644 drivers/staging/gpib/hp_82341/Makefile
 create mode 100644 drivers/staging/gpib/hp_82341/hp_82341.c
 create mode 100644 drivers/staging/gpib/hp_82341/hp_82341.h
 create mode 100644 drivers/staging/gpib/include/amcc5920.h
 create mode 100644 drivers/staging/gpib/include/amccs5933.h
 create mode 100644 drivers/staging/gpib/include/gpibP.h
 create mode 100644 drivers/staging/gpib/include/gpib_pci_ids.h
 create mode 100644 drivers/staging/gpib/include/gpib_proto.h
 create mode 100644 drivers/staging/gpib/include/gpib_state_machines.h
 create mode 100644 drivers/staging/gpib/include/gpib_types.h
 create mode 100644 drivers/staging/gpib/include/nec7210.h
 create mode 100644 drivers/staging/gpib/include/nec7210_registers.h
 create mode 100644 drivers/staging/gpib/include/plx9050.h
 create mode 100644 drivers/staging/gpib/include/quancom_pci.h
 create mode 100644 drivers/staging/gpib/include/tms9914.h
 create mode 100644 drivers/staging/gpib/include/tnt4882_registers.h
 create mode 100644 drivers/staging/gpib/ines/Makefile
 create mode 100644 drivers/staging/gpib/ines/ines.h
 create mode 100644 drivers/staging/gpib/ines/ines_gpib.c
 create mode 100644 drivers/staging/gpib/lpvo_usb_gpib/Makefile
 create mode 100644 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
 create mode 100644 drivers/staging/gpib/nec7210/Makefile
 create mode 100644 drivers/staging/gpib/nec7210/board.h
 create mode 100644 drivers/staging/gpib/nec7210/nec7210.c
 create mode 100644 drivers/staging/gpib/ni_usb/Makefile
 create mode 100644 drivers/staging/gpib/ni_usb/ni_usb_gpib.c
 create mode 100644 drivers/staging/gpib/ni_usb/ni_usb_gpib.h
 create mode 100644 drivers/staging/gpib/pc2/Makefile
 create mode 100644 drivers/staging/gpib/pc2/pc2_gpib.c
 create mode 100644 drivers/staging/gpib/tms9914/Makefile
 create mode 100644 drivers/staging/gpib/tms9914/tms9914.c
 create mode 100644 drivers/staging/gpib/tnt4882/Makefile
 create mode 100644 drivers/staging/gpib/tnt4882/mite.c
 create mode 100644 drivers/staging/gpib/tnt4882/mite.h
 create mode 100644 drivers/staging/gpib/tnt4882/tnt4882_gpib.c
 create mode 100644 drivers/staging/gpib/uapi/gpib_ioctl.h
 create mode 100644 drivers/staging/gpib/uapi/gpib_user.h
 delete mode 100644 drivers/staging/iio/TODO
 delete mode 100644 drivers/staging/olpc_dcon/Kconfig
 delete mode 100644 drivers/staging/olpc_dcon/Makefile
 delete mode 100644 drivers/staging/olpc_dcon/TODO
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon.c
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon.h
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
 delete mode 100644 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
 delete mode 100644 drivers/staging/rtl8192e/Kconfig
 delete mode 100644 drivers/staging/rtl8192e/Makefile
 delete mode 100644 drivers/staging/rtl8192e/TODO
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/Kconfig
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/Makefile
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_core.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_core.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/table.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_BA.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_BAProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_HT.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_HTProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_Qos.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_TS.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_TSProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib.h
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_tkip.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_wep.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_module.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_rx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_softmac.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_softmac_wx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_tx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_wx.c
 delete mode 100644 drivers/staging/rtl8712/Kconfig
 delete mode 100644 drivers/staging/rtl8712/Makefile
 delete mode 100644 drivers/staging/rtl8712/TODO
 delete mode 100644 drivers/staging/rtl8712/basic_types.h
 delete mode 100644 drivers/staging/rtl8712/drv_types.h
 delete mode 100644 drivers/staging/rtl8712/ethernet.h
 delete mode 100644 drivers/staging/rtl8712/hal_init.c
 delete mode 100644 drivers/staging/rtl8712/ieee80211.c
 delete mode 100644 drivers/staging/rtl8712/ieee80211.h
 delete mode 100644 drivers/staging/rtl8712/mlme_linux.c
 delete mode 100644 drivers/staging/rtl8712/mlme_osdep.h
 delete mode 100644 drivers/staging/rtl8712/mp_custom_oid.h
 delete mode 100644 drivers/staging/rtl8712/os_intfs.c
 delete mode 100644 drivers/staging/rtl8712/osdep_intf.h
 delete mode 100644 drivers/staging/rtl8712/osdep_service.h
 delete mode 100644 drivers/staging/rtl8712/recv_linux.c
 delete mode 100644 drivers/staging/rtl8712/recv_osdep.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_cmd.c
 delete mode 100644 drivers/staging/rtl8712/rtl8712_cmd.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_efuse.c
 delete mode 100644 drivers/staging/rtl8712/rtl8712_efuse.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_event.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_gp_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_gp_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_hal.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_io.c
 delete mode 100644 drivers/staging/rtl8712/rtl8712_led.c
 delete mode 100644 drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_powersave_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_recv.c
 delete mode 100644 drivers/staging/rtl8712/rtl8712_recv.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_security_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_spec.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_wmac_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl8712_xmit.c
 delete mode 100644 drivers/staging/rtl8712/rtl8712_xmit.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_cmd.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_cmd.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_debug.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_eeprom.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_eeprom.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_event.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_ht.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_io.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_io.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_linux.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_set.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_set.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_led.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_mlme.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_mlme.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_mp.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_mp.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_mp_ioctl.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_mp_ioctl.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_pwrctrl.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_pwrctrl.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_recv.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_recv.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_rf.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_security.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_security.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_sta_mgt.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_wlan_sme.h
 delete mode 100644 drivers/staging/rtl8712/rtl871x_xmit.c
 delete mode 100644 drivers/staging/rtl8712/rtl871x_xmit.h
 delete mode 100644 drivers/staging/rtl8712/sta_info.h
 delete mode 100644 drivers/staging/rtl8712/usb_halinit.c
 delete mode 100644 drivers/staging/rtl8712/usb_intf.c
 delete mode 100644 drivers/staging/rtl8712/usb_ops.c
 delete mode 100644 drivers/staging/rtl8712/usb_ops.h
 delete mode 100644 drivers/staging/rtl8712/usb_ops_linux.c
 delete mode 100644 drivers/staging/rtl8712/usb_osintf.h
 delete mode 100644 drivers/staging/rtl8712/wifi.h
 delete mode 100644 drivers/staging/rtl8712/wlan_bssdef.h
 delete mode 100644 drivers/staging/rtl8712/xmit_linux.c
 delete mode 100644 drivers/staging/rtl8712/xmit_osdep.h
 delete mode 100644 drivers/staging/rts5208/Kconfig
 delete mode 100644 drivers/staging/rts5208/Makefile
 delete mode 100644 drivers/staging/rts5208/TODO
 delete mode 100644 drivers/staging/rts5208/general.c
 delete mode 100644 drivers/staging/rts5208/general.h
 delete mode 100644 drivers/staging/rts5208/ms.c
 delete mode 100644 drivers/staging/rts5208/ms.h
 delete mode 100644 drivers/staging/rts5208/rtsx.c
 delete mode 100644 drivers/staging/rts5208/rtsx.h
 delete mode 100644 drivers/staging/rts5208/rtsx_card.c
 delete mode 100644 drivers/staging/rts5208/rtsx_card.h
 delete mode 100644 drivers/staging/rts5208/rtsx_chip.c
 delete mode 100644 drivers/staging/rts5208/rtsx_chip.h
 delete mode 100644 drivers/staging/rts5208/rtsx_scsi.c
 delete mode 100644 drivers/staging/rts5208/rtsx_scsi.h
 delete mode 100644 drivers/staging/rts5208/rtsx_sys.h
 delete mode 100644 drivers/staging/rts5208/rtsx_transport.c
 delete mode 100644 drivers/staging/rts5208/rtsx_transport.h
 delete mode 100644 drivers/staging/rts5208/sd.c
 delete mode 100644 drivers/staging/rts5208/sd.h
 delete mode 100644 drivers/staging/rts5208/spi.c
 delete mode 100644 drivers/staging/rts5208/spi.h
 delete mode 100644 drivers/staging/rts5208/xd.c
 delete mode 100644 drivers/staging/rts5208/xd.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
 delete mode 100644 drivers/staging/vt6655/Kconfig
 delete mode 100644 drivers/staging/vt6655/Makefile
 delete mode 100644 drivers/staging/vt6655/TODO
 delete mode 100644 drivers/staging/vt6655/baseband.c
 delete mode 100644 drivers/staging/vt6655/baseband.h
 delete mode 100644 drivers/staging/vt6655/card.c
 delete mode 100644 drivers/staging/vt6655/card.h
 delete mode 100644 drivers/staging/vt6655/channel.c
 delete mode 100644 drivers/staging/vt6655/channel.h
 delete mode 100644 drivers/staging/vt6655/desc.h
 delete mode 100644 drivers/staging/vt6655/device.h
 delete mode 100644 drivers/staging/vt6655/device_cfg.h
 delete mode 100644 drivers/staging/vt6655/device_main.c
 delete mode 100644 drivers/staging/vt6655/dpc.c
 delete mode 100644 drivers/staging/vt6655/dpc.h
 delete mode 100644 drivers/staging/vt6655/key.c
 delete mode 100644 drivers/staging/vt6655/key.h
 delete mode 100644 drivers/staging/vt6655/mac.c
 delete mode 100644 drivers/staging/vt6655/mac.h
 delete mode 100644 drivers/staging/vt6655/power.c
 delete mode 100644 drivers/staging/vt6655/power.h
 delete mode 100644 drivers/staging/vt6655/rf.c
 delete mode 100644 drivers/staging/vt6655/rf.h
 delete mode 100644 drivers/staging/vt6655/rxtx.c
 delete mode 100644 drivers/staging/vt6655/rxtx.h
 delete mode 100644 drivers/staging/vt6655/srom.c
 delete mode 100644 drivers/staging/vt6655/srom.h
 delete mode 100644 drivers/staging/vt6655/test
 delete mode 100644 drivers/staging/vt6656/Kconfig
 delete mode 100644 drivers/staging/vt6656/Makefile
 delete mode 100644 drivers/staging/vt6656/TODO
 delete mode 100644 drivers/staging/vt6656/baseband.c
 delete mode 100644 drivers/staging/vt6656/baseband.h
 delete mode 100644 drivers/staging/vt6656/card.c
 delete mode 100644 drivers/staging/vt6656/card.h
 delete mode 100644 drivers/staging/vt6656/channel.c
 delete mode 100644 drivers/staging/vt6656/channel.h
 delete mode 100644 drivers/staging/vt6656/desc.h
 delete mode 100644 drivers/staging/vt6656/device.h
 delete mode 100644 drivers/staging/vt6656/key.c
 delete mode 100644 drivers/staging/vt6656/key.h
 delete mode 100644 drivers/staging/vt6656/mac.c
 delete mode 100644 drivers/staging/vt6656/mac.h
 delete mode 100644 drivers/staging/vt6656/main_usb.c
 delete mode 100644 drivers/staging/vt6656/power.c
 delete mode 100644 drivers/staging/vt6656/power.h
 delete mode 100644 drivers/staging/vt6656/rf.c
 delete mode 100644 drivers/staging/vt6656/rf.h
 delete mode 100644 drivers/staging/vt6656/rxtx.c
 delete mode 100644 drivers/staging/vt6656/rxtx.h
 delete mode 100644 drivers/staging/vt6656/usbpipe.c
 delete mode 100644 drivers/staging/vt6656/usbpipe.h
 delete mode 100644 drivers/staging/vt6656/wcmd.c
 delete mode 100644 drivers/staging/vt6656/wcmd.h
 delete mode 100644 include/linux/if_ltalk.h
 delete mode 100644 include/net/lib80211.h
 create mode 100644 lib/packing_test.c
 delete mode 100644 net/appletalk/dev.c
 create mode 100644 net/core/rtnl_net_debug.c
 delete mode 100644 net/wireless/lib80211.c

