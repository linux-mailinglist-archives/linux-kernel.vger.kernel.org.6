Return-Path: <linux-kernel+bounces-529038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F7A41F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7EA1888FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AE221F2E;
	Mon, 24 Feb 2025 12:28:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C7219300;
	Mon, 24 Feb 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400129; cv=none; b=smRMfrLDhebqKUtOjmu6umWlD1+5oWH50YvYCqHz0UUV1Segsuw05QZ5MabT9q6uB538QdR8S8STLK+r7rD8ut4IJDHIloF6AptiQhJ6bYltSypXyEV+VCj/engRnnBAg117HujIX/O5RURsnELTGoKQBCGSkPY+rfwln4VR6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400129; c=relaxed/simple;
	bh=pjCT8GnN5URh9+O3Mk/D3ODBt/SpAHceG8+ST95Y7Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVcN8AbOX6/R+77ymNp+6zBHaO0mhcUcIn8ibYh0foco8Eeqpg9x7adNApF29aJaqBTI3FBWzqtUPYhovSIwHh/BCgu7KwENeG7tgXwbbpUk7aM54xlVUdLFIIS7dKziOslCrFmTAPEz3Tc9trmSQn5LhiU/CqbdrrDMJ6wYag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26B3E1756;
	Mon, 24 Feb 2025 04:29:01 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A1923F6A8;
	Mon, 24 Feb 2025 04:28:41 -0800 (PST)
Date: Mon, 24 Feb 2025 12:28:34 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/7] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Message-ID: <Z7xl8h8Sh_UWYbI3@pluto>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-1-3aee005968c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-imx-lmm-cpu-v2-1-3aee005968c1@nxp.com>

On Wed, Feb 12, 2025 at 03:40:23PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX95 Logical Machine Management and CPU Protocol documentation.
> 

Hi,

a few comments below.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 737 ++++++++++++++++++++++++
>  1 file changed, 737 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
> index b2dfd6c46ca2f5f12f0475c24cb54c060e9fa421..78a09cd8102becd5584d28bdef18df2d77fb7e7c 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
> @@ -32,6 +32,461 @@ port, and deploy the SM on supported processors.
>  The SM implements an interface compliant with the Arm SCMI Specification
>  with additional vendor specific extensions.
>  

In general I noticed that there is NOT specified anywhere if all the
following commands are mandatory or optional in your protocol: would be
better to be specified, as it is I will assume that are all mandatory.

> +SCMI_LMM: System Control and Management Logical Machine Management Vendor Protocol
> +==================================================================================
> +
> +This protocol is intended for boot, shutdown, and reset of other logical
> +machines (LM). It is usually used to allow one LM(e.g. OSPM) to manage
> +another LM which is usually an offload or accelerator engine.. Notifications
> +from this protocol can also be used to manage a communication link to another
> +LM. The LMM protocol provides functions to:
> +
> +- Describe the protocol version.
> +- Discover implementation attributes.
> +- Discover the LMs defined in the system.
> +- Boot an LM.
> +- Shutdown an LM (gracefully or forcibly).
> +- Reset an LM (gracefully or forcibly).
> +- Wake an LM from suspend.
> +- Suspend an LM (gracefully).
> +- Read boot/shutdown/reset information for an LM.
> +- Get notifications when an LM boots or shuts down (e.g. LM[X] requested
> +  notification of LM[Y] boots or shuts down, when LM[Y] boots or shuts down,
> +  SCMI firmware will send notification to LM[X]).
> +
> +'Graceful' means asking LM itself to shutdown/reset/etc (e.g. sending
> +notification to Linux, Then Linux reboots or powers down itself).
> +
> +Commands:
> +_________
> +
> +PROTOCOL_VERSION
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x0
> +protocol_id: 0x80
> +
> ++---------------+--------------------------------------------------------------+
> +|Return values                                                                 |
> ++---------------+--------------------------------------------------------------+
> +|Name           |Description                                                   |
> ++---------------+--------------------------------------------------------------+
> +|int32 status   | See ARM SCMI Specification for status code definitions.      |
> ++---------------+--------------------------------------------------------------+
> +|uint32 version | For this revision of the specification, this value must be   |
> +|               | 0x10000.                                                     |
> ++---------------+--------------------------------------------------------------+
> +
> +PROTOCOL_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x1
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      | See ARM SCMI Specification for status code definitions.   |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Protocol attributes:                                       |
> +|                  |Bits[31:8] Reserved, must be zero.                         |
> +|                  |Bits[7:0] Number of Logical Machines                       |

...so this states how many LMs you have...ok...

> ++------------------+-----------------------------------------------------------+
> +
> +PROTOCOL_MESSAGE_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x2
> +protocol_id: 0x80
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
> +LMM_ATTRIBUTES
> +~~~~~~~~~~~~~~
> +
> +message_id: 0x3
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if valid attributes are returned.                 |
> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |DENIED: if the agent does not have permission to get info  |
> +|                  |for the LM specified by lmid.                              |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes | Bits[31:8] reserved.                                      |
> +|                  | Bits[7:0] Number of Logical Machines.                     |

...BUT this returns again the number of LMs while asking the attributes
of a specific LM ? .... is it a typo or what ? ...if it is just as a
sort of placeholder for when you'll have really LM's attributes to show,
consider that once this is documented and supported in this version of
your vendor protocol it will be needed to be kept and maintained...maybe
better just to declare this as zero in this version of the protocol if
you dont really have anything for this command in this version...(like
many times are defined the attributes fields in PROTOCOL_MESSAGE_ATTRIBUTES
above, if you really know you could want/need this command in the
future...is it used now ?

> ++------------------+-----------------------------------------------------------+
> +
> +LMM_BOOT
> +~~~~~~~~
> +
> +message_id: 0x4
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if LM successfully booted.                        |

...this and other commands below that cause a transition are a bit
ambiguos in their description IMHO...does this mean that on reception of
a SUCCESS the LM identified by lmid has successfully completed the boot ?

...or, as I suppose, this being an immmediate command, SUCCESS means something
like 'boot succesfully started', NOT that when this SUCCESS reply comes back the
LM has booted...also becuse I can see a lot of notifications defined down below to
signal the completion of such operations...

..if this is the case please clarify...

...if this is NOT the case and this is intended to return synchronoulsy
when the required operation has completed, even though such machines are
maybe (?) minimal/tiny compute systems, can you guarantee that they can boot/shutdown
etc in a reasonably short time not to hog the channel for too long (I mean
well before the configured transport timeout)...

> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> +|                  |DENIED: if the agent does not have permission to manage the|
> +|                  |the LM specified by lmid.                                  |
> ++------------------+-----------------------------------------------------------+
> +
> +LMM_RESET
> +~~~~~~~~~
> +
> +message_id: 0x5
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Reset flags:                                               |
> +|                  |Bits[31:1] Reserved, must be zero.                         |
> +|                  |Bit[0] Graceful request:                                   |
> +|                  |Set to 1 if the request is a graceful request.             |
> +|                  |Set to 0 if the request is a forceful request.             |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if LM successfully resets.                        |

Same ... does this simply mean LM reset issued successfully ?

> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> +|                  |DENIED: if the agent does not have permission to manage the|
> +|                  |the LM specified by lmid.                                  |
> ++------------------+-----------------------------------------------------------+
> +
> +LMM_SHUTDOWN
> +~~~~~~~~~~~~
> +
> +message_id: 0x6
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Reset flags:                                               |
> +|                  |Bits[31:1] Reserved, must be zero.                         |
> +|                  |Bit[0] Graceful request:                                   |
> +|                  |Set to 1 if the request is a graceful request.             |
> +|                  |Set to 0 if the request is a forceful request.             |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if LM successfully shutdowns.                     |

Same...I suppose the shutdown has been sucessfully issued and could be
still in progress...if this is not the case I fear this immediate
command will potentially hog the channel for too long....

> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> +|                  |DENIED: if the agent does not have permission to manage the|
> +|                  |the LM specified by lmid.                                  |
> ++------------------+-----------------------------------------------------------+
> +
> +LMM_WAKE
> +~~~~~~~~
> +
> +message_id: 0x7
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if LM successfully wakes.                         |

Same...I suppose you can know when an LM is fully woken only from the
dedicated notification receipt...

> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> +|                  |DENIED: if the agent does not have permission to manage the|
> +|                  |the LM specified by lmid.                                  |
> ++------------------+-----------------------------------------------------------+
> +
> +LMM_SUSPEND
> +~~~~~~~~~~~
> +
> +message_id: 0x8
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if LM successfully suspends.                      |

Same..I suppose the SCMI server will know when the suspend for this LM is
effective and will send a notification, so this is again only an indication
that the suspend process has started...

> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> +|                  |DENIED: if the agent does not have permission to manage the|
> +|                  |the LM specified by lmid.                                  |
> ++------------------+-----------------------------------------------------------+
> +

In general, you could also think to make the bahvour of all this
operation configurable like teh RESET protocol does...so you could ask
for an LMM op to complete synchronously OR instead let it happen
asynchnously in the background after the command-request has completed
and then wait for one of the existing notification...

...again if this is already the expected behaviour please clarifiy the sync/async
kind of execution that is expected when you issue such commands

> +LMM_NOTIFY
> +~~~~~~~~~~
> +
> +message_id: 0x9
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |Notification flags:                                        |
> +|                  |Bits[31:3] Reserved, must be zero.                         |
> +|                  |Bit[3] Wake (resume) notification:                         |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification.                               |
> +|                  |Bit[2] Suspend (sleep) notification:                       |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification.                               |
> +|                  |Bit[1] Shutdown (off) notification:                        |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification.                               |
> +|                  |Bit[0] Boot (on) notification:                             |
> +|                  |Set to 1 to send notification.                             |
> +|                  |Set to 0 if no notification                                |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the notification state successfully updated.   |
> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |INVALID_PARAMETERS: if input attributes flag specifies     |
> +|                  |unsupported or invalid configurations.                     |
> +|                  |DENIED: if the agent does not have permission to request   |
> +|                  |the notification.                                          |
> ++------------------+-----------------------------------------------------------+
> +
> +LMM_RESET_REASON
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0xA
> +protocol_id: 0x80

What is this...a bit of explanation would be fine given that this
command is not straightforward to understand like the previous
boot/suspend etc...

> +
> ++---------------------+--------------------------------------------------------+
> +|Parameters                                                                    |
> ++---------------------+--------------------------------------------------------+
> +|Name                 |Description                                             |
> ++---------------------+--------------------------------------------------------+
> +|uint32 lmid          |ID of the Logical Machine                               |
> ++---------------------+--------------------------------------------------------+
> +|Return values                                                                 |
> ++---------------------+--------------------------------------------------------+
> +|Name                 |Description                                             |
> ++---------------------+--------------------------------------------------------+
> +|int32 status         |SUCCESS: if LM successfully suspends.                   |

? typo ?

> +|                     |NOT_FOUND: if lmId not points to a valid logical machine|
> +|                     |DENIED: if the agent does not have permission to request|
> +|                     |the reset reason.                                       |
> ++---------------------+--------------------------------------------------------+
> +|uint32 bootflags     |Boot reason flags. This parameter has the format:       |
> +|                     |Bits[31] Valid.                                         |
> +|                     |Set to 1 if the entire reason is valid.                 |
> +|                     |Set to 0 if the entire reason is not valid.             |
> +|                     |Bits[30:29] Reserved, must be zero.                     |
> +|                     |Bit[28] Valid origin:                                   |
> +|                     |Set to 1 if the origin field is valid.                  |
> +|                     |Set to 0 if the origin field is not valid.              |
> +|                     |Bits[27:24] Origin.                                     |

Are this origin values defined anywhere ?

> +|                     |Bit[23] Valid err ID:                                   |
> +|                     |Set to 1 if the error ID field is valid.                |
> +|                     |Set to 0 if the error ID field is not valid.            |

And this errors ID ? which value should I expect here...and to what this
errors refer to...

> +|                     |Bits[22:8] Error ID.                                    |
> +|                     |Bit[7:0] Reason(WDOG, POR, FCCU and etc)                |
> ++---------------------+--------------------------------------------------------+
> +|uint32 shutdownflags |Shutdown reason flags. This parameter has the format:   |
> +|                     |Bits[31] Valid.                                         |
> +|                     |Set to 1 if the entire reason is valid.                 |
> +|                     |Set to 0 if the entire reason is not valid.             |
> +|                     |Bits[30:29] Number of valid extended info words.        |
> +|                     |Bit[28] Valid origin:                                   |
> +|                     |Set to 1 if the origin field is valid.                  |
> +|                     |Set to 0 if the origin field is not valid.              |

Ditto.
> +|                     |Bits[27:24] Origin.                                     |
> +|                     |Bit[23] Valid err ID:                                   |
> +|                     |Set to 1 if the error ID field is valid.                |
> +|                     |Set to 0 if the error ID field is not valid.            |
> +|                     |Bits[22:8] Error ID.                                    |
Ditto.
> +|                     |Bit[7:0] Reason                                         |
Ditto.
> ++---------------------+--------------------------------------------------------+
> +|uint32 extinfo[0,20] |Array of extended info words(e.g. fault pc)             |
> ++---------------------+--------------------------------------------------------+

..so what does this field represent....is this a fixed sized array ? seems more likely
to be dynamically sized in range [0,20] AFAICU...

...now...if it is dynamically sized:

+ there should be a size field declaring the size of the returned
answer, if not you should rely on the transport size to know where the
message ends (unless if hard-coded based on the above flags...in that
case explain and document)

+ you cannot assume that such a potentially big reply reply fit into a
single message due to possible limitations of the transport
sizes...IOW you should think about a 'multi-part' message like many
exist in SCMI where the reply reports returned+remaining entries...
..how can yo be sure to fit in any transport...this message has
currently a potential max payload reply of 96 bytes ...

> +
> +LMM_POWER_ON
> +~~~~~~~~~~~~
> +
> +message_id: 0xB
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |ID of the Logical Machine                                  |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if LM successfully powers on.                     |

Beside the same consideration as above regarding what this SUCCESS
mean...what is meant to be the difference between LMM_POWER_ON and LMM_BOOT ?

> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> +|                  |DENIED: if the agent does not have permission to manage the|
> +|                  |the LM specified by lmid.                                  |
> ++------------------+-----------------------------------------------------------+
> +
> +LMM_RESET_VECTOR_SET
> +~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0xC
> +protocol_id: 0x80
> +
> ++-----------------------+------------------------------------------------------+
> +|Parameters                                                                    |
> ++-----------------------+------------------------------------------------------+
> +|Name                   |Description                                           |
> ++-----------------------+------------------------------------------------------+
> +|uint32 lmid            |ID of the Logical Machine                             |
> ++-----------------------+------------------------------------------------------+
> +|uint32 cpuid           |ID of the CPU inside the LM                           |
> ++-----------------------+------------------------------------------------------+
> +|uint32 flags           |Reset vector flags                                    |
> +|                       |Bits[31:1] Reserved, must be zero.                    |
> +|                       |Bit[0] Table flag.                                    |
> +|                       |Set to 1 if vector is the vector table base address   |

So what is this when Bit[0] is set to zero instead ?

> ++-----------------------+------------------------------------------------------+
> +|uint32 resetVectorLow  |Lower vector                                          |
> ++-----------------------+------------------------------------------------------+
> +|uint32 resetVectorHigh |Higher vector                                         |
> ++-----------------------+------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if LM successfully powers on.                     |

...typo ?...

> +|                  |NOT_FOUND: if lmId not points to a valid logical machine,  |
> +|                  |or cpuId is not valid.
> +|                  |INVALID_PARAMETERS: if reset vector is invalid.            |
> +|                  |DENIED: if the agent does not have permission to set the   |
> +|                  |the reset vector for the CPU in the LM.                    |
> ++------------------+-----------------------------------------------------------+
> +
> +NEGOTIATE_PROTOCOL_VERSION
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x10
> +protocol_id: 0x80
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
> +LMM_EVENT
> +~~~~~~~~~
> +
> +message_id: 0x0
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 lmid       |Identifier for the LM that caused the transition.          |
> ++------------------+-----------------------------------------------------------+
> +|uint32 eventlm    |Identifier for the LM the event is for.                    |

So this is the LM that the event refer to ? i.e. this LM eventlm is the
one that is booting/resetting/shutdown ? 
if this is the case, maybe better as:

	"Identifier of the LM this event refers to."

> ++------------------+-----------------------------------------------------------+
> +|uint32 flags      |LM events:                                                 |
> +|                  |Bits[31:3] Reserved, must be zero.                         |
> +|                  |Bit[3] Wake (resume) event:                                |
> +|                  |1 LM has awakened.                                         |
> +|                  |0 not a wake event.                                        |
> +|                  |Bit[2] Suspend (sleep) event:                              |
> +|                  |1 LM has suspended.                                        |
> +|                  |0 not a suspend event.                                     |
> +|                  |Bit[1] Shutdown (off) event:                               |
> +|                  |1 LM has shutdown.                                         |
> +|                  |0 not a shutdown event.                                    |
> +|                  |Bit[0] Boot (on) event:                                    |
> +|                  |1 LM has booted.                                           |
> +|                  |0 not a boot event.                                        |
> ++------------------+-----------------------------------------------------------+
> +
>  SCMI_BBM: System Control and Management BBM Vendor Protocol
>  ==============================================================
>  
> @@ -436,6 +891,288 @@ protocol_id: 0x81
>  |                  |0 no button change detected.                               |
>  +------------------+-----------------------------------------------------------+
>  
> +SCMI_CPU: System Control and Management CPU Vendor Protocol
> +==============================================================
> +
> +This protocol allows an agent to start or stop a CPU. It is used to manage
> +auxiliary CPUs in an LM (e.g. additional cores in an AP cluster or
> +Cortex-M cores).
> +Note: For cores in AP cluster, ATF will use CPU protocol to handle them.

So this is sort of a PSCI-by-proxy in which you ask the server to turn
on/off some of the LM CPUs ?

First question would be is not enough to just ask for a specific LM to
be booted with LMM ? or add to the LMM protocol a way to specifiy the
'level' of boot that you ask for an LM...I may miss many details but it
seems to me a bit odd that you are allowd to ask, from the agent that
could have just requested an LM to boot to have some CPUs ON or OFF...
...and specify the boot/resume address vectors here to use when turning
ON...

Maybe a bit more of explanation of the rationale and expectations here
could help understanding the differet needs from LMM

> +
> +The CPU protocol provides functions to:
> +
> +- Describe the protocol version.
> +- Discover implementation attributes.
> +- Discover the CPUs defined in the system.
> +- Start a CPU.
> +- Stop a CPU.
> +- Set the boot and resume addresses for a CPU.
> +- Set the sleep mode of a CPU.
> +- Configure wake-up sources for a CPU.
> +- Configure power domain reactions (LPM mode and retention mask) for a CPU.
> +- The CPU IDs can be found in the CPU section of the SoC DEVICE: SM Device
> +  Interface. They can also be found in the SoC RM. See the CPU Mode Control
> +  (CMC) list in General Power Controller (GPC) section.
> +
> +CPU settings are not aggregated and setting their state is normally exclusive
> +to one client.
> +
> +Commands:
> +_________
> +
> +PROTOCOL_VERSION
> +~~~~~~~~~~~~~~~~
> +
> +message_id: 0x0
> +protocol_id: 0x82
> +
> ++---------------+--------------------------------------------------------------+
> +|Return values                                                                 |
> ++---------------+--------------------------------------------------------------+
> +|Name           |Description                                                   |
> ++---------------+--------------------------------------------------------------+
> +|int32 status   | See ARM SCMI Specification for status code definitions.      |
> ++---------------+--------------------------------------------------------------+
> +|uint32 version | For this revision of the specification, this value must be   |
> +|               | 0x10000.                                                     |
> ++---------------+--------------------------------------------------------------+
> +
> +PROTOCOL_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x1
> +protocol_id: 0x82
> +
> ++---------------+--------------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      | See ARM SCMI Specification for status code definitions.   |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Protocol attributes:                                       |
> +|                  |Bits[31:16] Reserved, must be zero.                        |
> +|                  |Bits[15:0] Number of CPUs                                  |
> ++------------------+-----------------------------------------------------------+
> +
> +PROTOCOL_MESSAGE_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x2
> +protocol_id: 0x82
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
> +CPU_ATTRIBUTES
> +~~~~~~~~~~~~~~
> +
> +message_id: 0x4
> +protocol_id: 0x82
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 cpuid      |Identifier for the CPU                                     |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if valid attributes are returned successfully.    |
> +|                  |NOT_FOUND: if the cpuid is not valid.                      |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Bits[31:0] Reserved, must be zero                          |
> ++------------------+-----------------------------------------------------------+
> +|char name[16]     |NULL terminated ASCII string with CPU name up to 16 bytes  |
> ++------------------+-----------------------------------------------------------+
> +
> +CPU_START
> +~~~~~~~~~
> +
> +message_id: 0x4
> +protocol_id: 0x82
> +

Any constraint to call this only after having successfully called RESET_VECROR_SET ?

> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 cpuid      |Identifier for the CPU                                     |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the cpu is started successfully.               |
> +|                  |NOT_FOUND: if cpuid is not valid.                          |
> +|                  |DENIED: the calling agent is not allowed to start this CPU.|
> ++------------------+-----------------------------------------------------------+
> +
> +CPU_STOP
> +~~~~~~~~
> +
> +message_id: 0x5
> +protocol_id: 0x82
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 cpuid      |Identifier for the CPU                                     |
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the cpu is started successfully.               |
> +|                  |NOT_FOUND: if cpuid is not valid.                          |
> +|                  |DENIED: the calling agent is not allowed to stop this CPU. |
> ++------------------+-----------------------------------------------------------+
> +
> +CPU_RESET_VECTOR_SET
> +~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x6
> +protocol_id: 0x82
> +
> ++----------------------+-------------------------------------------------------+
> +|Parameters                                                                    |
> ++----------------------+-------------------------------------------------------+
> +|Name                  |Description                                            |
> ++----------------------+-------------------------------------------------------+
> +|uint32 cpuid          |Identifier for the CPU                                 |
> ++----------------------+-------------------------------------------------------+
> +|uint32 flags          |Reset vector flags:                                    |
> +|                      |Bit[31] Resume flag.                                   |
> +|                      |Set to 1 to update the reset vector used on resume.    |
> +|                      |Bit[30] Boot flag.                                     |
> +|                      |Set to 1 to update the reset vector used for boot.     |
> +|                      |Bits[29:1] Reserved, must be zero.                     |
> +|                      |Bit[0] Table flag.                                     |
> +|                      |Set to 1 if vector is the vector table base address.   |
> ++----------------------+-------------------------------------------------------+
> +|uint32 resetVectorLow |Lower vector:                                          |
> +|                      |If bit[0] of flags is 0, the lower 32 bits of the      |
> +|                      |physical address where the CPU should execute from on  |
> +|                      |reset. If bit[0] of flags is 1, the lower 32 bits of   |
> +|                      |the vector table base address                          |
> ++----------------------+-------------------------------------------------------+
> +|uint32 resetVectorhigh|Upper vector:                                          |
> +|                      |If bit[0] of flags is 0, the upper 32 bits of the      |
> +|                      |physical address where the CPU should execute from on  |
> +|                      |reset. If bit[0] of flags is 1, the upper 32 bits of   |
> +|                      |the vector table base address                          |
> ++----------------------+-------------------------------------------------------+
> +|Return values                                                                 |
> ++----------------------+-------------------------------------------------------+
> +|Name                  |Description                                            |
> ++----------------------+-------------------------------------------------------+
> +|int32 status          |SUCCESS: if the CPU reset vector is set successfully.  |
> +|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
> +|                      |INVALID_PARAMETERS: the requested vector type is not   |
> +|                      |supported by this CPU.                                 |
> +|                      |DENIED: the calling agent is not allowed to set the    |
> +|                      |reset vector of this CPU                               |
> ++----------------------+-------------------------------------------------------+
> +
> +CPU_SLEEP_MODE_SET
> +~~~~~~~~~~~~~~~~~~
> +message_id: 0x7
> +protocol_id: 0x82
> +
> ++----------------------+-------------------------------------------------------+
> +|Parameters                                                                    |
> ++----------------------+-------------------------------------------------------+
> +|Name                  |Description                                            |
> ++----------------------+-------------------------------------------------------+
> +|uint32 cpuid          |Identifier for the CPU                                 |
> ++----------------------+-------------------------------------------------------+
> +|uint32 flags          |Sleep mode flags:                                      |
> +|                      |Bits[31:1] Reserved, must be zero.                     |
> +|                      |Bit[0] IRQ mux:                                        |
> +|                      |If set to 1 the wakeup mux source is the GIC, else if 0|
> +|                      |then the GPC                                           |

What is the GPC in this context ?

> ++----------------------+-------------------------------------------------------+
> +|uint32 sleepmode      |target sleep mode                                      |

What values can this assume ? Is there any predefined sleep value here ?

> ++----------------------+-------------------------------------------------------+
> +|Return values                                                                 |
> ++----------------------+-------------------------------------------------------+
> +|Name                  |Description                                            |
> ++----------------------+-------------------------------------------------------+
> +|int32 status          |SUCCESS: if the CPU sleep mode is set successfully.    |
> +|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
> +|                      |INVALID_PARAMETERS: the sleepmode or flags is invalid. |
> +|                      |DENIED: the calling agent is not allowed to configure  |
> +|                      |the CPU                                                |
> ++----------------------+-------------------------------------------------------+
> +
> +CPU_INFO_GET
> +~~~~~~~~~~~~
> +message_id: 0xC
> +protocol_id: 0x82
> +
> ++----------------------+-------------------------------------------------------+
> +|Parameters                                                                    |
> ++----------------------+-------------------------------------------------------+
> +|Name                  |Description                                            |
> ++----------------------+-------------------------------------------------------+
> +|uint32 cpuid          |Identifier for the CPU                                 |
> ++----------------------+-------------------------------------------------------+
> +|Return values                                                                 |
> ++----------------------+-------------------------------------------------------+
> +|Name                  |Description                                            |
> ++----------------------+-------------------------------------------------------+
> +|int32 status          |SUCCESS: if valid attributes are returned successfully.|
> +|                      |NOT_FOUND: if the cpuid is not valid.                  |
> ++----------------------+-------------------------------------------------------+
> +|uint32 runmode        |Run mode for the CPU                                   |

What are the possible runmode values ?

> ++----------------------+-------------------------------------------------------+
> +|uint32 sleepmode      |Sleep mode for the CPU                                 |
> ++----------------------+-------------------------------------------------------+
> +|uint32 resetvectorlow |Reset vector low 32 bits for the CPU                   |
> ++----------------------+-------------------------------------------------------+
> +|uint32 resetvecothigh |Reset vector high 32 bits for the CPU                  |
> ++----------------------+-------------------------------------------------------+
> +
> +NEGOTIATE_PROTOCOL_VERSION
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +message_id: 0x10
> +protocol_id: 0x82
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
>  SCMI_MISC: System Control and Management MISC Vendor Protocol
>  ================================================================
>

Thanks,
Cristian

