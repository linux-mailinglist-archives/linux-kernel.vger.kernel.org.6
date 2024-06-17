Return-Path: <linux-kernel+bounces-217920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0837C90B62F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029591C22CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F414D2B9;
	Mon, 17 Jun 2024 16:22:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8339513BAC4;
	Mon, 17 Jun 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641329; cv=none; b=tWs2YgZFhwBEe6pOvA66pXrhUcgaUQHV+He6zuDEshPVaZoCRVb9Hfc56SHyZ7TWud4oJOFkYXYU3A0Uz+3l81aUHs6Z1BtYqOABaofMRUTcvl2dRdYgPqXdqEcZ5tNfL9MQVzaje5r2ygHX5nyCP4InAhn9qgT59tliX7V+DwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641329; c=relaxed/simple;
	bh=NbORyknaNTt6qGSvCRGY8ymzgeHLJyudVhDE30LmKGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4JoVvL18GUw0UHkH/pELImvchW2UCdZTae9BVnsRX4rDPRmiZCfyYINtI/y9+pqumf2DSqSiXe15W86mvG3ZB1FPkO55bNNBSBCmNapxTfrFjwMX3ITxCPxT4dTZ4muwNWHoe87BxY9u/x7u6s97/rXjbJWinYzVWr+DBKF40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902E2DA7;
	Mon, 17 Jun 2024 09:22:28 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D2D3F64C;
	Mon, 17 Jun 2024 09:22:01 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:21:59 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] Documentation: firmware-guide: add NXP i.MX95
 SCMI documentation
Message-ID: <ZnBip_XY1PAkTEbB@pluto>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-1-dc456995d590@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-1-dc456995d590@nxp.com>

On Fri, May 24, 2024 at 04:56:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add NXP i.MX95 System Control Management Interface(SCMI) vendor
> extensions protocol documentation.
> 

Hi Peng, 

thanks for adding this iMX SCMI vendor-protocols extensions docs; I am
not totally sure if we will end up placing this SCMI related stuff at this
level inside Documentation/firmware-guide, but these are details that can be
ironed out later...a few comments down below.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/firmware-guide/index.rst          |  10 +
>  Documentation/firmware-guide/nxp/imx95-scmi.rst | 877 ++++++++++++++++++++++++
>  Documentation/firmware-guide/nxp/index.rst      |  10 +
>  3 files changed, 897 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
> index 5355784ca0a2..8f66ae31337e 100644
> --- a/Documentation/firmware-guide/index.rst
> +++ b/Documentation/firmware-guide/index.rst
> @@ -4,6 +4,9 @@
>  The Linux kernel firmware guide
>  ===============================
>  
> +ACPI subsystem
> +==============
> +
>  This section describes the ACPI subsystem in Linux from firmware perspective.
>  
>  .. toctree::
> @@ -11,3 +14,10 @@ This section describes the ACPI subsystem in Linux from firmware perspective.
>  
>     acpi/index
>  
> +NXP firmware
> +============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   nxp/index
> diff --git a/Documentation/firmware-guide/nxp/imx95-scmi.rst b/Documentation/firmware-guide/nxp/imx95-scmi.rst
> new file mode 100644
> index 000000000000..bd87a961e4a5
> --- /dev/null
> +++ b/Documentation/firmware-guide/nxp/imx95-scmi.rst
> @@ -0,0 +1,877 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +===============================================================================
> +i.MX95 System Control and Management Interface(SCMI) Vendor Protocols Extension
> +===============================================================================
> +
> +:Copyright: |copy| 2024 NXP
> +
> +:Author: Peng Fan <peng.fan@nxp.com>
> +
> +The System Manager (SM) is a low-level system function which runs on a System
> +Control Processor (SCP) to support isolation and management of power domains,
> +clocks, resets, sensors, pins, etc. on complex application processors. It often
> +runs on a Cortex-M processor and provides an abstraction to many of the
> +underlying features of the hardware. The primary purpose of the SM is to allow
> +isolation between software running on different cores in the SoC. It does this
> +by having exclusive access to critical resources such as those controlling
> +power, clocks, reset, PMIC, etc. and then providing an RPC interface to those
> +clients. This allows the SM to provide access control, arbitration, and
> +aggregation policies for those shared critical resources.
> +
> +This document covers all the information necessary to understand, maintain,
> +port, and deploy the SM on supported processors.
> +
> +The SM implements an interface compliant with the Arm SCMI 3.2 Specification

I would not specify the exact version, since the SCMI protocol is anyway
completely discoverable and in case you evolve your support you will
have to update endlessly the doc.

> +with vendor specific extensions.

 with additional vendor specific extensions.

> +
> +SCMI_BBM: System Control and Management Interface Driver (BBM)

SCMI_BBM: System Control and Management BBM Vendor Protocol


> +==============================================================
> +
> +This protocol is intended provide access to the battery-backed module. This
> +contains persistent storage (GPR), an RTC, and the ON/OFF button. The protocol
> +can also provide access to similar functions implemented via external board
> +components. The BBM protocol provides functions to:
> +
> +- Describe the protocol version.
> +- Discover implementation attributes.
> +- Read/write GPR
> +- Discover the RTCs available in the system.
> +- Read/write the RTC time in seconds and ticks
> +- Set an alarm (per LM) in seconds

what is an LM ? maybe a worth a note about it above in the intro

> +- Get notifications on RTC update, alarm, or rollover.
> +- Get notification on ON/OFF button activity.
> +
> +For most SoC, there is one on-chip RTC (e.g. in BBNSM) and this is RTC ID 0.
> +Board code can add additional GPR and RTC.
> +
> +GPR are not aggregated. The RTC time is also not aggregated. Setting these
> +sets for all so normally exclusive access would be granted to one agent for
> +each. However, RTC alarms are maintained for each LM and the hardware is
> +programmed with the next nearest alarm time. So only one agent in an LM should
> +be given access rights to set an RTC alarm.
> +
> +Commands:
> +_________
> +
> +PROTOCOL_VERSION
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x0
> +protocol_id: 0x81
> +
> ++---------------+--------------------------------------------------------------+
> +|Return values                                                                 |
> ++---------------+--------------------------------------------------------------+
> +|Name           |Description                                                   |
> ++---------------+--------------------------------------------------------------+
> +|int32 status   | See ARM SCMI Specification v3.2 section 4.1.4 for status     |
> +|               | code definitions.                                            |

I understand that you want to mention a specific table in a specific
document for a well-defined version, BUT I would drop here and all over this
versioning and refs and just generically say 

| See ARM SCMI Specification for status code definitions.                         |

to avoid all the future churn in keeping the refs updated here, since,
as said, all versions and features are discoverable and the Linux
kernel SCMI stack takes care usually to downgrade to match the detected
protocol version.


> ++---------------+--------------------------------------------------------------+
> +|uint32 version | For this revision of the specification, this value must be   |
> +|               | 0x10000.                                                     |
> ++---------------+--------------------------------------------------------------+
> +
> +PROTOCOL_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x1
> +protocol_id: 0x81
> +
> ++---------------+--------------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      | See ARM SCMI Specification v3.2 section 4.1.4 for status  |
> +|                  | code definitions.                                         |

Ditto.

> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes | Bits[31:8] Number of RTCs.                                |
> +|                  | Bits[15:0] Number of persistent storage (GPR) words.      |
> ++------------------+-----------------------------------------------------------+
> +
> +PROTOCOL_MESSAGE_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x2
> +protocol_id: 0x81
> +
> ++---------------+--------------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: in case the message is implemented and available  |
> +|                  |to use.                                                    |
> +|                  |NOT_FOUND: if the message identified by message_id is      |
> +|                  |invalid or not implemented                                 |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Flags that are associated with a specific function in the  |
> +|                  |protocol. For all functions in this protocol, this         |
> +|                  |parameter has a value of 0                                 |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_GPR_SET
> +~~~~~~~~~~~
> +
> +message_id: 0x3
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of GPR to write                                      |
> ++------------------+-----------------------------------------------------------+
> +|uint32 value      |32-bit value to write to the GPR                           |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the GPR was successfully written.              |
> +|                  |NOT_FOUND: if the index is not valid.                      |
> +|                  |DENIED: if the agent does not have permission to write     |
> +|                  |the specified GPR                                          |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_GPR_GET
> +~~~~~~~~~~~
> +
> +message_id: 0x4
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of GPR to read                                       |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the GPR was successfully written.              |

read

> +|                  |NOT_FOUND: if the index is not valid.                      |
> +|                  |DENIED: if the agent does not have permission to write     |

 to read (if it make sense to deny the read...)

> +|                  |the specified GPR.                                         |
> ++------------------+-----------------------------------------------------------+
> +|uint32 value      |32-bit value read from the GPR                             |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_RTC_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x5
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of RTC                                               |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: returned the attributes.                          |
> +|                  |NOT_FOUND: Index is invalid.                               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Bit[31:24] Bit width of RTC seconds.                       |
> +|                  |Bit[23:16] Bit width of RTC ticks.                         |
> +|                  |Bits[15:0] RTC ticks per second                            |
> ++------------------+-----------------------------------------------------------+
> +|uint8 name[16]    |Null-terminated ASCII string of up to 16 bytes in length   |
> +|                  |describing the RTC name                                    |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_RTC_TIME_SET
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x6
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of RTC                                               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
> +|                  |Bit[0] RTC time format:                                    |
> +|                  |Set to 1 if the time is in ticks.                          |
> +|                  |Set to 0 if the time is in seconds                         |
> ++------------------+-----------------------------------------------------------+
> +|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds/ticks.    |
> +|                  |Upper word: Upper 32 bits of the time in seconds/ticks.    |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: RTC time was successfully set.                    |
> +|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
> +|                  |INVALID_PARAMETERS: time is not valid                      |
> +|                  |(beyond the range of the RTC).                             |
> +|                  |DENIED: the agent does not have permission to set the RTC. |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_RTC_TIME_GET
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x7
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of RTC                                               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
> +|                  |Bit[0] RTC time format:                                    |
> +|                  |Set to 1 if the time is in ticks.                          |
> +|                  |Set to 0 if the time is in seconds                         |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: RTC time was successfully set.                    |

get

> +|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
> ++------------------+-----------------------------------------------------------+
> +|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds/ticks.    |
> +|                  |Upper word: Upper 32 bits of the time in seconds/ticks.    |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_RTC_ALARM_SET
> +~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x8
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of RTC                                               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
> +|                  |Bit[0] RTC enable flag:                                    |
> +|                  |Set to 1 if the RTC alarm should be enabled.               |
> +|                  |Set to 0 if the RTC alarm should be disabled               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds.          |
> +|                  |Upper word: Upper 32 bits of the time in seconds.          |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: RTC time was successfully set.                    |
> +|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
> +|                  |INVALID_PARAMETERS: time is not valid                      |
> +|                  |(beyond the range of the RTC).                             |
> +|                  |DENIED: the agent does not have permission to set the RTC  |
> +|                  |alarm                                                      |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_BUTTON_GET
> +~~~~~~~~~~~~~~
> +
> +message_id: 0x9
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the button status was read.                    |
> +|                  |Other value: ARM SCMI Specification v3.2 section 4.1.4.    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 state      |State of the ON/OFF button                                 |
> ++------------------+-----------------------------------------------------------+

How the states are codified ? 0/1 ? with the remaining bits reserevd ?

> +
> +BBM_RTC_NOTIFY
> +~~~~~~~~~~~~~~
> +
> +message_id: 0xA
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of RTC                                               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Notification flags                                         |
> +|                  |Bits[31:3] Reserved, must be zero.                         |
> +|                  |Bit[2] Update enable:                                      |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification.                               |
> +|                  |Bit[1] Rollover enable:                                    |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification.                               |
> +|                  |Bit[0] Alarm enable:                                       |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification                                |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: notification configuration was successfully       |
> +|                  |updated.                                                   |
> +|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
> +|                  |DENIED: the agent does not have permission to request RTC  |
> +|                  |notifications.                                             |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_BUTTON_NOTIFY
> +~~~~~~~~~~~~~~~~~
> +
> +message_id: 0xB
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Notification flags                                         |
> +|                  |Bits[31:1] Reserved, must be zero.                         |
> +|                  |Bit[0] Enable button:                                      |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification                                |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: notification configuration was successfully       |
> +|                  |updated.                                                   |
> +|                  |DENIED: the agent does not have permission to request      |
> +|                  |button notifications.                                      |
> ++------------------+-----------------------------------------------------------+
> +
> +NEGOTIATE_PROTOCOL_VERSION
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x10
> +protocol_id: 0x81
> +
> ++--------------------+---------------------------------------------------------+
> +|Parameters                                                                    |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|uint32 version      |The negotiated protocol version the agent intends to use |
> ++--------------------+---------------------------------------------------------+
> +|Return values                                                                 |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|int32 status        |SUCCESS: if the negotiated protocol version is supported |
> +|                    |by the platform. All commands, responses, and            |
> +|                    |notifications post successful return of this command must|
> +|                    |comply with the negotiated version.                      |
> +|                    |NOT_SUPPORTED: if the protocol version is not supported. |
> ++--------------------+---------------------------------------------------------+
> +
> +Notifications
> +_____________
> +
> +BBM_RTC_EVENT
> +~~~~~~~~~~~~~
> +
> +message_id: 0x0
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |RTC events:                                                |
> +|                  |Bits[31:2] Reserved, must be zero.                         |
> +|                  |Bit[1] RTC rollover notification:                          |
> +|                  |1 RTC rollover detected.                                   |
> +|                  |0 no RTC rollover detected.                                |
> +|                  |Bit[0] RTC alarm notification:                             |
> +|                  |1 RTC alarm generated.                                     |
> +|                  |0 no RTC alarm generated.                                  |
> ++------------------+-----------------------------------------------------------+
> +
> +BBM_BUTTON_EVENT
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x1
> +protocol_id: 0x81
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |RTC events:                                                |
> ++------------------+-----------------------------------------------------------+
> +|                  |Button events:                                             |
> +|                  |Bits[31:1] Reserved, must be zero.                         |
> +|                  |Bit[0] Button notification:                                |
> +|                  |1 button change detected.                                  |
> +|                  |0 no button change detected.                               |
> ++------------------+-----------------------------------------------------------+
> +
> +SCMI_MISC: System Control and Management Interface Driver (MISC)

SCMI_MISC: System Control and Management MISC Vendor Protocol

Miscellaneous
> +================================================================
> +
> +Provides misc. functions. This includes controls that are misc. settings/actions

miscellaneous

> +that must be exposed from the SM to agents. They are device specific and are
> +usually define to access bit fields in various mix block control modules,
> +IOMUX_GPR, and other GPR/CSR owned by the SM. This protocol supports the
> +following functions:
> +
> +- Describe the protocol version.
> +- Discover implementation attributes.
> +- Set/Get a control.
> +- Initiate an action on a control.
> +- Obtain platform (i.e. SM) build information.
> +- Obtain ROM passover data.
> +- Read boot/shutdown/reset information for the LM or the system.
> +
> +Commands:
> +_________
> +
> +PROTOCOL_VERSION
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x0
> +protocol_id: 0x84
> +
> ++---------------+--------------------------------------------------------------+
> +|Return values                                                                 |
> ++---------------+--------------------------------------------------------------+
> +|Name           |Description                                                   |
> ++---------------+--------------------------------------------------------------+
> +|int32 status   | See ARM SCMI Specification v3.2 section 4.1.4 for status     |
> +|               | code definitions.                                            |

Ditto.

> ++---------------+--------------------------------------------------------------+
> +|uint32 version | For this revision of the specification, this value must be   |
> +|               | 0x10000.                                                     |
> ++---------------+--------------------------------------------------------------+
> +
> +PROTOCOL_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x1
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |See ARM SCMI Specification v3.2 section 4.1.4 for status   |
> +|                  |code definitions.                                          |
> ++------------------+-----------------------------------------------------------+

Ditto

> +|uint32 attributes |Protocol attributes:                                       |
> +|                  |Bits[31:24] Reserved, must be zero.                        |
> +|                  |Bits[23:16] Number of reasons.                             |

here and all the occurences down below... is it 'reason' or 'region' ?
In case it is indeed 'reasons' I am not sure ot understand what is the
usage of reason IDs in the protoocol...

> +|                  |Bits[15:0] Number of controls                              |
> ++------------------+-----------------------------------------------------------+
> +
> +PROTOCOL_MESSAGE_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x2
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: in case the message is implemented and available  |
> +|                  |to use.                                                    |
> +|                  |NOT_FOUND: if the message identified by message_id is      |
> +|                  |invalid or not implemented                                 |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Flags that are associated with a specific function in the  |
> +|                  |protocol. For all functions in this protocol, this         |
> +|                  |parameter has a value of 0                                 |
> ++------------------+-----------------------------------------------------------+
> +
> +MISC_CONTROL_SET
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x3
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of the control                                       |
> ++------------------+-----------------------------------------------------------+
> +|uint32 num        |Size of the value data in words                            |
> ++------------------+-----------------------------------------------------------+
> +|uint32 val[8]     |value data array                                           |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the control was set successfully.              |
> +|                  |NOT_FOUND: if the index is not valid.                      |
> +|                  |DENIED: if the agent does not have permission to set the   |
> +|                  |control                                                    |
> ++------------------+-----------------------------------------------------------+
> +
> +MISC_CONTROL_GET
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x4
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of the control                                       |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the control was set successfully.              |

get

> +|                  |NOT_FOUND: if the index is not valid.                      |
> +|                  |DENIED: if the agent does not have permission to get the   |
> +|                  |control                                                    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 num        |Size of the return data in words                           |
> ++------------------+-----------------------------------------------------------+
> +|uint32 val[8]     |value data array                                           |
> ++------------------+-----------------------------------------------------------+
> +
> +MISC_CONTROL_ACTION
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x5
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of the control                                       |
> ++------------------+-----------------------------------------------------------+
> +|uint32 action	   |Action for the control                                     |
> ++------------------+-----------------------------------------------------------+
> +|uint32 numarg	   |Size of the argument data                                  |

Max 8, it seems...please specify

> ++------------------+-----------------------------------------------------------+
> +|uint32 arg[8]	   |Argument data array                                        |

arg[N] with N in [0, numarg -1] ?

... a bit of formatting issues too above...

> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the action was set successfully.               |
> +|                  |NOT_FOUND: if the index is not valid.                      |
> +|                  |DENIED: if the agent does not have permission to get the   |
> +|                  |control                                                    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 num        |Size of the return data in words                           |

max 8 ?

> ++------------------+-----------------------------------------------------------+
> +|uint32 val[8]     |value data array                                           |
> ++------------------+-----------------------------------------------------------+

val[N] with N in [0, num -1] as above ... I suppose

> +
> +MISC_DISCOVER_BUILD_INFO
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +

Which build version this refers to ? the SM fw build version and metadata ?

> +message_id: 0x6
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the build info was got successfully.           |
> +|                  |NOT_SUPPORTED: if the data is not available.               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 buildnum   |Build number                                               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 buildcommit|Most significant 32 bits of the git commit hash            |
> ++------------------+-----------------------------------------------------------+
> +|uint8 date[16]    |Date of build. Null terminated ASCII string of up to 16    |
> +|                  |bytes in length                                            |
> ++------------------+-----------------------------------------------------------+
> +|uint8 time[16]    |Time of build. Null terminated ASCII string of up to 16    |
> +|                  |bytes in length                                            |
> ++------------------+-----------------------------------------------------------+
> +
> +MISC_ROM_PASSOVER_GET
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +This function is used to obtain the ROM passover data. The returned block of
> +words is structured as defined in the ROM passover section in the SoC RM.
> +

what is a ROM passover exactly ?

> +message_id: 0x7
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the data was got successfully.                 |
> +|                  |NOT_SUPPORTED: if the data is not available.               |
> ++------------------+-----------------------------------------------------------+
> +|uint32 num        |Size of the passover data in words                         |
> ++------------------+-----------------------------------------------------------+
> +|uint32_t data[8]  |Passover data array                                        |
> ++------------------+-----------------------------------------------------------+
> +
> +MISC_CONTROL_NOTIFY
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x8
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 index      |Index of control                                           |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Notification flags, varies by control                      |

So basically this is to somehow enable notifs on the specified index
BUT the flag field syntax is completely opaque and varies by the control type...
...how is this even used in the code ? there should be at least a bit
dedicatd to enable/disable right ?

> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: notification configuration was successfully       |
> +|                  |updated.                                                   |
> +|                  |NOT_FOUND: control id not exists.                          |
> +|                  |INVALID_PARAMETERS: if the input attributes flag specifies |
> +|                  |unsupported or invalid configurations..                    |
> +|                  |DENIED: if the calling agent is not permitted to request   |
> +|                  |the notification.                                          |
> ++------------------+-----------------------------------------------------------+
> +
> +MISC_REASON_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~~~~

? as above said... REASON ?

> +
> +message_id: 0x9
> +protocol_id: 0x84
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 reasonid   |Identifier for the reason                                  |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if valid reason attributes are returned           |
> +|                  |NOT_FOUND: if reasonId pertains to a non-existent reason.  |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Reason attributes. This parameter has the following        |
> +|                  |format: Bits[31:0] Reserved, must be zero                  |
> +|                  |Bits[15:0] Number of persistent storage (GPR) words.       |
> ++------------------+-----------------------------------------------------------+
> +|uint8 name[16]    |Null-terminated ASCII string of up to 16 bytes in length   |
> +|                  |describing the reason                                      |
> ++------------------+-----------------------------------------------------------+
> +
> +MISC_RESET_REASON
> +~~~~~~~~~~~~~~~~~
> +
> +message_id: 0xA
> +protocol_id: 0x84
> +

So is this a GET ? MISC_RESET_REASON_GET ?

> ++--------------------+---------------------------------------------------------+
> +|Parameters                                                                    |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|uint32 flags        |Reason flags. This parameter has the following format:   |
> +|                    |Bits[31:1] Reserved, must be zero.                       |
> +|                    |Bit[0] System:                                           |
> +|                    |Set to 1 to return the system reason.                    |
> +|                    |Set to 0 to return the LM reason                         |
> ++--------------------+---------------------------------------------------------+
> +|Return values                                                                 |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|int32 status        |SUCCESS: reset reason return                             |
> ++--------------------+---------------------------------------------------------+
> +|uint32 bootflags    |Boot reason flags. This parameter has the format:        |
> +|                    |Bits[31] Valid.                                          |
> +|                    |Set to 1 if the entire reason is valid.                  |
> +|                    |Set to 0 if the entire reason is not valid.              |
> +|                    |Bits[30:29] Reserved, must be zero.                      |
> +|                    |Bit[28] Valid origin:                                    |
> +|                    |Set to 1 if the origin field is valid.                   |
> +|                    |Set to 0 if the origin field is not valid.               |
> +|                    |Bits[27:24] Origin.                                      |
> +|                    |Bit[23] Valid err ID:                                    |
> +|                    |Set to 1 if the error ID field is valid.                 |
> +|                    |Set to 0 if the error ID field is not valid.             |
> +|                    |Bits[22:8] Error ID.                                     |
> +|                    |Bit[7:0] Reason                                          |
> ++--------------------+---------------------------------------------------------+
> +|uint32 shutdownflags|Shutdown reason flags. This parameter has the format:    |
> +|                    |Bits[31] Valid.                                          |
> +|                    |Set to 1 if the entire reason is valid.                  |
> +|                    |Set to 0 if the entire reason is not valid.              |
> +|                    |Bits[30:29] Number of valid extended info words.         |
> +|                    |Bit[28] Valid origin:                                    |
> +|                    |Set to 1 if the origin field is valid.                   |
> +|                    |Set to 0 if the origin field is not valid.               |
> +|                    |Bits[27:24] Origin.                                      |
> +|                    |Bit[23] Valid err ID:                                    |
> +|                    |Set to 1 if the error ID field is valid.                 |
> +|                    |Set to 0 if the error ID field is not valid.             |
> +|                    |Bits[22:8] Error ID.                                     |
> +|                    |Bit[7:0] Reason                                          |
> ++--------------------+---------------------------------------------------------+
> +|uint32 extinfo[8]   |Array of extended info words                             |
> ++--------------------+---------------------------------------------------------+
> +
> +MISC_SI_INFO
> +~~~~~~~~~~~~
> +

MISC_SI_INFO_GET ?

> +message_id: 0xB
> +ROM passoverprotocol_id: 0x84
> +
> ++--------------------+---------------------------------------------------------+
> +|Return values                                                                 |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|int32 status        |SUCCESS: silicon info return                             |
> ++--------------------+---------------------------------------------------------+
> +|uint32 deviceid     |Silicon specific device ID                               |
> ++--------------------+---------------------------------------------------------+
> +|uint32 sirev        |Silicon specific revision                                |
> ++--------------------+---------------------------------------------------------+
> +|uint32 partnum      |Silicon specific part number                             |
> ++--------------------+---------------------------------------------------------+
> +|uint8 siname[16]    |Silicon name/revision. Null terminated ASCII string of up|
> +|                    |to 16 bytes in length                                    |
> ++--------------------+---------------------------------------------------------+
> +
> +MISC_CFG_INFO
> +~~~~~~~~~~~~~
> +

MISC_CFG_INFO_GET

> +message_id: 0xC
> +protocol_id: 0x84
> +
> ++--------------------+---------------------------------------------------------+
> +|Return values                                                                 |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|int32 status        |SUCCESS: config name return                              |
> +|                    |NOT_SUPPORTED: name not available                        |
> ++--------------------+---------------------------------------------------------+
> +|uint32 msel         |Mode selector value                                      |
> ++--------------------+---------------------------------------------------------+
> +|uint8 cfgname[16]   |config file basename. Null terminated ASCII string of up |
> +|                    |to 16 bytes in length                                    |
> ++--------------------+---------------------------------------------------------+
> +
> +MISC_SYSLOG
> +~~~~~~~~~~~
> +
> +message_id: 0xD
> +protocol_id: 0x84
> +
> ++--------------------+---------------------------------------------------------+
> +|Parameters                                                                    |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|uint32 flags        |Device specific flags that might impact the data returned|
> +|                    |or clearing of the data                                  |
> ++--------------------+---------------------------------------------------------+
> +|uint32 logindex     |Index to the first log word. Will be the first element in|
> +|                    |the return array                                         |
> ++--------------------+---------------------------------------------------------+
> +|Return values                                                                 |
> ++--------------------+---------------------------------------------------------+
> +|Name                |Description                                              |
> ++--------------------+---------------------------------------------------------+
> +|int32 status        |SUCCESS: reset reason return                             |

??

> ++--------------------+---------------------------------------------------------+
> +|uint32 numLogflags  |Descriptor for the log data returned by this call.       |
> +|                    |Bits[31:20] Number of remaining log words.               |
> +|                    |Bits[15:12] Reserved, must be zero.                      |
> +|                    |Bits[11:0] Number of log words that are returned by this |
> +|                    |call                                                     |
> ++--------------------+---------------------------------------------------------+
> +|uint32 syslog[16]   |Log data array                                           |
> ++--------------------+---------------------------------------------------------+

This should be syslog[N} with N defined by bits[11:0] in numLogflags, by
the definition itself of multi-part SCMI command...the number of returned
entries is limited by the platform dinamically based on the max size that
the configure underlying transport allows....it could be more OR less
than 16...this way is seems that you always carry around 16 bytes max,
potentially with unused bytes if returned words are far less...

Thanks,
Cristian

