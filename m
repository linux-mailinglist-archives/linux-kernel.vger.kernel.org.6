Return-Path: <linux-kernel+bounces-531280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20505A43E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D13BFA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166BF267B0E;
	Tue, 25 Feb 2025 11:54:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30026869C;
	Tue, 25 Feb 2025 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484473; cv=none; b=KKelu7JY8u/vh4LlDmxgN3eJyOyNOEG+fNggNr/s4O2WHHcSFCuDFRcwhbHtT4JEEwoUVzPziQUht9ca0HmmJlaeBkL3zM3KszB1uLplunNKVEUn8SAcEfADlOryk2i0SWgkO6A/zTRsC+Ocb3KuopMGQNmql1SL/gSdlVoNH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484473; c=relaxed/simple;
	bh=UeafEbFVPhK6uXlw1agjsjmtT4OhzY87QrZ4nGa0IyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu3e8g9m/6ZJSngF9MZvSwaXefitcmAoWD8BDeQhfh63odoSHMmBHW3Vefd1Pg72rUurfflOHAcevHephMT7ZQ2OLjvjxWotsS+5GA7wi3UMXb5GW3GXTD33JB1wOLDEXJnVEuZ/laENQ0wf1XxMJ8aZ0oIM2SzO2R3efeGy46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BABB1516;
	Tue, 25 Feb 2025 03:54:46 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B68283F6A8;
	Tue, 25 Feb 2025 03:54:27 -0800 (PST)
Date: Tue, 25 Feb 2025 11:54:25 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <Z72vcSmOMwIER--_@pluto>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-1-3aee005968c1@nxp.com>
 <Z7xl8h8Sh_UWYbI3@pluto>
 <20250225090709.GA25303@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225090709.GA25303@nxa18884-linux>

On Tue, Feb 25, 2025 at 05:07:09PM +0800, Peng Fan wrote:
> Hi Cristian,
> 
> On Mon, Feb 24, 2025 at 12:28:34PM +0000, Cristian Marussi wrote:
> >On Wed, Feb 12, 2025 at 03:40:23PM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> Add i.MX95 Logical Machine Management and CPU Protocol documentation.
> >> 
> >
> >Hi,
> >
> >a few comments below.
> >
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 737 ++++++++++++++++++++++++
> >>  1 file changed, 737 insertions(+)
> >> 
> >> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
> >> index b2dfd6c46ca2f5f12f0475c24cb54c060e9fa421..78a09cd8102becd5584d28bdef18df2d77fb7e7c 100644
> >> --- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
> >> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
> >> @@ -32,6 +32,461 @@ port, and deploy the SM on supported processors.
> >>  The SM implements an interface compliant with the Arm SCMI Specification
> >>  with additional vendor specific extensions.
> >>  
> >
> >In general I noticed that there is NOT specified anywhere if all the
> >following commands are mandatory or optional in your protocol: would be
> >better to be specified, as it is I will assume that are all mandatory.
> 
> The Doc from [1] does not specify optional or mandatory, I need check
> with firmware owner to see whether this could be added.
> 
> [1]https://github.com/nxp-imx/imx-sm
> 

Ok...just specify for each command what is the expectation.

> >
> >> +SCMI_LMM: System Control and Management Logical Machine Management Vendor Protocol
> >> +==================================================================================
> >> +
> >> +
> [...]
> >> +PROTOCOL_ATTRIBUTES
> >> +~~~~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x1
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      | See ARM SCMI Specification for status code definitions.   |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 attributes |Protocol attributes:                                       |
> >> +|                  |Bits[31:8] Reserved, must be zero.                         |
> >> +|                  |Bits[7:0] Number of Logical Machines                       |
> >
> >...so this states how many LMs you have...ok...
> >
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +PROTOCOL_MESSAGE_ATTRIBUTES
> >> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x2
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: in case the message is implemented and available  |
> >> +|                  |to use.                                                    |
> >> +|                  |NOT_FOUND: if the message identified by message_id is      |
> >> +|                  |invalid or not implemented                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 attributes |Flags that are associated with a specific function in the  |
> >> +|                  |protocol. For all functions in this protocol, this         |
> >> +|                  |parameter has a value of 0                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_ATTRIBUTES
> >> +~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x3
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if valid attributes are returned.                 |
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |DENIED: if the agent does not have permission to get info  |
> >> +|                  |for the LM specified by lmid.                              |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 attributes | Bits[31:8] reserved.                                      |
> >> +|                  | Bits[7:0] Number of Logical Machines.                     |
> >
> >...BUT this returns again the number of LMs while asking the attributes
> >of a specific LM ? .... is it a typo or what ? ...if it is just as a
> >sort of placeholder for when you'll have really LM's attributes to show,
> >consider that once this is documented and supported in this version of
> >your vendor protocol it will be needed to be kept and maintained...maybe
> >better just to declare this as zero in this version of the protocol if
> >you dont really have anything for this command in this version...(like
> >many times are defined the attributes fields in PROTOCOL_MESSAGE_ATTRIBUTES
> >above, if you really know you could want/need this command in the
> >future...is it used now ?
> 
> My bad. This should be updated with below
> +------------------+-----------------------------------------------------------+
> |uint32 attributes | Bits[31:0] reserved. must be zero                         |
> +------------------+-----------------------------------------------------------+
> |uint32 state      | Current state of the LM                                   |
> +------------------+-----------------------------------------------------------+
> |uint32 errStatus  | Last error status recorded                                |
> +------------------+-----------------------------------------------------------+
> |char name[16]     | A NULL terminated ASCII string with the LM name, of up    |
> |                  | to 16 bytes                                               |
> +------------------+-----------------------------------------------------------+
> 

ok

> >
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_BOOT
> >> +~~~~~~~~
> >> +
> >> +message_id: 0x4
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if LM successfully booted.                        |
> >
> >...this and other commands below that cause a transition are a bit
> >ambiguos in their description IMHO...does this mean that on reception of
> >a SUCCESS the LM identified by lmid has successfully completed the boot ?
> >
> >...or, as I suppose, this being an immmediate command, SUCCESS means something
> >like 'boot succesfully started', NOT that when this SUCCESS reply comes back the
> >LM has booted...also becuse I can see a lot of notifications defined down below to
> >signal the completion of such operations...
> >
> >..if this is the case please clarify...
> 
> right. This means the LM has been boot successfully started. Not means
> LM fully function up.
> 
> I will updated this with "SUCCESS: if LM boots successfully started"
>

ok
 
> 
> >
> >...if this is NOT the case and this is intended to return synchronoulsy
> >when the required operation has completed, even though such machines are
> >maybe (?) minimal/tiny compute systems, can you guarantee that they can boot/shutdown
> >etc in a reasonably short time not to hog the channel for too long (I mean
> >well before the configured transport timeout)...
> >
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> >> +|                  |DENIED: if the agent does not have permission to manage the|
> >> +|                  |the LM specified by lmid.                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_RESET
> >> +~~~~~~~~~
> >> +
> >> +message_id: 0x5
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 flags      |Reset flags:                                               |
> >> +|                  |Bits[31:1] Reserved, must be zero.                         |
> >> +|                  |Bit[0] Graceful request:                                   |
> >> +|                  |Set to 1 if the request is a graceful request.             |
> >> +|                  |Set to 0 if the request is a forceful request.             |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if LM successfully resets.                        |
> >
> >Same ... does this simply mean LM reset issued successfully ?
> 
> For graceful reset, platform will issue a notification to agent and just return,
> agent will do the reset, as linux reboot.
> For forceful reset, platform will do the force reset of agent, this is longer
> time.
> 
> I will update with "The LMM RESET command finished successfully in graceful reset
> or LM successfully resets in forceful reset"
> 

ok

> >
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> >> +|                  |DENIED: if the agent does not have permission to manage the|
> >> +|                  |the LM specified by lmid.                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_SHUTDOWN
> >> +~~~~~~~~~~~~
> >> +
> >> +message_id: 0x6
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 flags      |Reset flags:                                               |
> >> +|                  |Bits[31:1] Reserved, must be zero.                         |
> >> +|                  |Bit[0] Graceful request:                                   |
> >> +|                  |Set to 1 if the request is a graceful request.             |
> >> +|                  |Set to 0 if the request is a forceful request.             |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if LM successfully shutdowns.                     |
> >
> >Same...I suppose the shutdown has been sucessfully issued and could be
> >still in progress...if this is not the case I fear this immediate
> >command will potentially hog the channel for too long....
> 
> For graceful shutdown, platform will issue a notification to agent and just return,
> agent will do shutdown.
> For forceful shutdown, platform will do the force shutdown of agent, this is longer
> time.
> 
> I will update with "The LMM shutdown command finished successfully in graceful request 
> or LM successfully shutdown in forceful request"
> 

Yes please, in general for all this cases you should clearly state if
the action is expected to be completed sunchronously with the immediate
response of asynchronously and signaled by an optional notification...

..I think it is important to clarify the expectations since you really
do NOT use SCMI async commands (with DELAYED RESPONSES) but a mix of
sync immediate commands and later notification on completion
(AFAIU)...so better to be clear all over this commnds..

> >
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> >> +|                  |DENIED: if the agent does not have permission to manage the|
> >> +|                  |the LM specified by lmid.                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_WAKE
> >> +~~~~~~~~
> >> +
> >> +message_id: 0x7
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if LM successfully wakes.                         |
> >
> >Same...I suppose you can know when an LM is fully woken only from the
> >dedicated notification receipt...
> 
> I will updated this with "SUCCESS: if LM wake command successfully returns"
>

ok
 
> >
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> >> +|                  |DENIED: if the agent does not have permission to manage the|
> >> +|                  |the LM specified by lmid.                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_SUSPEND
> >> +~~~~~~~~~~~
> >> +
> >> +message_id: 0x8
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if LM successfully suspends.                      |
> >
> >Same..I suppose the SCMI server will know when the suspend for this LM is
> >effective and will send a notification, so this is again only an indication
> >that the suspend process has started...
> 
> Right.
> I will updated this with "SUCCESS: if LM suspend command successfully returns"
>

ok
 
> >
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> >> +|                  |DENIED: if the agent does not have permission to manage the|
> >> +|                  |the LM specified by lmid.                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >
> >In general, you could also think to make the bahvour of all this
> >operation configurable like teh RESET protocol does...so you could ask
> >for an LMM op to complete synchronously OR instead let it happen
> >asynchnously in the background after the command-request has completed
> >and then wait for one of the existing notification...
> >
> >...again if this is already the expected behaviour please clarifiy the sync/async
> >kind of execution that is expected when you issue such commands
> 
> Yes, for graceful, it is async; for forceful, it is sync.
> If command not has graceful/forceful, such as lm wake/suspend, it is async
> 

Yes please specify this sync vs async completion as specified above and
the expected optional notifs

> >
> >> +LMM_NOTIFY
> >> +~~~~~~~~~~
> >> +
> >> +message_id: 0x9
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 flags      |Notification flags:                                        |
> >> +|                  |Bits[31:3] Reserved, must be zero.                         |
> >> +|                  |Bit[3] Wake (resume) notification:                         |
> >> +|                  |Set to 1 to send notification.                             |
> >> +|                  |Set to 0 if no notification.                               |
> >> +|                  |Bit[2] Suspend (sleep) notification:                       |
> >> +|                  |Set to 1 to send notification.                             |
> >> +|                  |Set to 0 if no notification.                               |
> >> +|                  |Bit[1] Shutdown (off) notification:                        |
> >> +|                  |Set to 1 to send notification.                             |
> >> +|                  |Set to 0 if no notification.                               |
> >> +|                  |Bit[0] Boot (on) notification:                             |
> >> +|                  |Set to 1 to send notification.                             |
> >> +|                  |Set to 0 if no notification                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if the notification state successfully updated.   |
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |INVALID_PARAMETERS: if input attributes flag specifies     |
> >> +|                  |unsupported or invalid configurations.                     |
> >> +|                  |DENIED: if the agent does not have permission to request   |
> >> +|                  |the notification.                                          |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_RESET_REASON
> >> +~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0xA
> >> +protocol_id: 0x80
> >
> >What is this...a bit of explanation would be fine given that this
> >command is not straightforward to understand like the previous
> >boot/suspend etc...
> 
> This function returns the boot/shutdown/reset reason for an LM.
> 
> Such as POR, WDOG and etc.
> 
> >
> >> +
> >> ++---------------------+--------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++---------------------+--------------------------------------------------------+
> >> +|Name                 |Description                                             |
> >> ++---------------------+--------------------------------------------------------+
> >> +|uint32 lmid          |ID of the Logical Machine                               |
> >> ++---------------------+--------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++---------------------+--------------------------------------------------------+
> >> +|Name                 |Description                                             |
> >> ++---------------------+--------------------------------------------------------+
> >> +|int32 status         |SUCCESS: if LM successfully suspends.                   |
> >
> >? typo ?
> 
> Sorry. This should be "the reset reason of the LM successfully updated"
> 
> >
> >> +|                     |NOT_FOUND: if lmId not points to a valid logical machine|
> >> +|                     |DENIED: if the agent does not have permission to request|
> >> +|                     |the reset reason.                                       |
> >> ++---------------------+--------------------------------------------------------+
> >> +|uint32 bootflags     |Boot reason flags. This parameter has the format:       |
> >> +|                     |Bits[31] Valid.                                         |
> >> +|                     |Set to 1 if the entire reason is valid.                 |
> >> +|                     |Set to 0 if the entire reason is not valid.             |
> >> +|                     |Bits[30:29] Reserved, must be zero.                     |
> >> +|                     |Bit[28] Valid origin:                                   |
> >> +|                     |Set to 1 if the origin field is valid.                  |
> >> +|                     |Set to 0 if the origin field is not valid.              |
> >> +|                     |Bits[27:24] Origin.                                     |
> >
> >Are this origin values defined anywhere ?
> 
> It varies in the current imx-sm implementation, there is no spec
> defining this, it could be a LMID or BBM register value or else.
> 

O_o ... ok... always a bit concerned about opaque stuff...not strong
opinion as of now...

> >
> >> +|                     |Bit[23] Valid err ID:                                   |
> >> +|                     |Set to 1 if the error ID field is valid.                |
> >> +|                     |Set to 0 if the error ID field is not valid.            |
> >
> >And this errors ID ? which value should I expect here...and to what this
> >errors refer to...
> >
> >> +|                     |Bits[22:8] Error ID.                                    |
> 
> There is not doc defining this. It just varies,
> It could be BBM button, agentID, faultID or a peripheral ID or else.

ok

> 
> >> +|                     |Bit[7:0] Reason(WDOG, POR, FCCU and etc)                |
> >> ++---------------------+--------------------------------------------------------+
> >> +|uint32 shutdownflags |Shutdown reason flags. This parameter has the format:   |
> >> +|                     |Bits[31] Valid.                                         |
> >> +|                     |Set to 1 if the entire reason is valid.                 |
> >> +|                     |Set to 0 if the entire reason is not valid.             |
> >> +|                     |Bits[30:29] Number of valid extended info words.        |
> >> +|                     |Bit[28] Valid origin:                                   |
> >> +|                     |Set to 1 if the origin field is valid.                  |
> >> +|                     |Set to 0 if the origin field is not valid.              |
> >
> >Ditto.
> >> +|                     |Bits[27:24] Origin.                                     |
> >> +|                     |Bit[23] Valid err ID:                                   |
> >> +|                     |Set to 1 if the error ID field is valid.                |
> >> +|                     |Set to 0 if the error ID field is not valid.            |
> >> +|                     |Bits[22:8] Error ID.                                    |
> >Ditto.
> >> +|                     |Bit[7:0] Reason                                         |
> >Ditto.
> 
> I will check imx-sm code and add more info for upper all three,
> but there is no documentation and it varies in imx-sm code repo.
> 

ok

> >> ++---------------------+--------------------------------------------------------+
> >> +|uint32 extinfo[0,20] |Array of extended info words(e.g. fault pc)             |
> >> ++---------------------+--------------------------------------------------------+
> >
> >..so what does this field represent....is this a fixed sized array ? seems more likely
> >to be dynamically sized in range [0,20] AFAICU...
> 
> This should be updated with "extinfo[3]". The length has been speicified in 
> "Bits[30:29] Number of valid extended info words."

Ah ok ... much better thanks for clarifying

> 
> >
> >...now...if it is dynamically sized:
> >
> >+ there should be a size field declaring the size of the returned
> >answer, if not you should rely on the transport size to know where the
> >message ends (unless if hard-coded based on the above flags...in that
> >case explain and document)
> 
> already specified in shutdownflags BITS[30:29]
> 

ok

> >
> >+ you cannot assume that such a potentially big reply reply fit into a
> >single message due to possible limitations of the transport
> >sizes...IOW you should think about a 'multi-part' message like many
> >exist in SCMI where the reply reports returned+remaining entries...
> >..how can yo be sure to fit in any transport...this message has
> >currently a potential max payload reply of 96 bytes ...
> >
> >> +
> >> +LMM_POWER_ON
> >> +~~~~~~~~~~~~
> >> +
> >> +message_id: 0xB
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |ID of the Logical Machine                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if LM successfully powers on.                     |
> >
> >Beside the same consideration as above regarding what this SUCCESS
> >mean...what is meant to be the difference between LMM_POWER_ON and LMM_BOOT ?
> 
> POWER ON, it is just power up, not means the LMM is kicked out to boot.
> BOOT, means LMM is kicked out to boot
> 
> For example, CPU has power and reset release function.
> power on, means power up the CPU
> boot, means reset release to let CPU run.

yep, got that, but I was just wondering what was the purpose to have
this distinction from the SCMI agent perspective

> 
> Especially for Cortex-M core, the TCM is in same power domain
> as Cortex-M. before booting the core, need power up the core to loading
> images to TCM, then boot the core.
> 

but it makes sense now a bit more....thanks for clarifying...

> >
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
> >> +|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
> >> +|                  |DENIED: if the agent does not have permission to manage the|
> >> +|                  |the LM specified by lmid.                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +LMM_RESET_VECTOR_SET
> >> +~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0xC
> >> +protocol_id: 0x80
> >> +
> >> ++-----------------------+------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++-----------------------+------------------------------------------------------+
> >> +|Name                   |Description                                           |
> >> ++-----------------------+------------------------------------------------------+
> >> +|uint32 lmid            |ID of the Logical Machine                             |
> >> ++-----------------------+------------------------------------------------------+
> >> +|uint32 cpuid           |ID of the CPU inside the LM                           |
> >> ++-----------------------+------------------------------------------------------+
> >> +|uint32 flags           |Reset vector flags                                    |
> >> +|                       |Bits[31:1] Reserved, must be zero.                    |
> >> +|                       |Bit[0] Table flag.                                    |
> >> +|                       |Set to 1 if vector is the vector table base address   |
> >
> >So what is this when Bit[0] is set to zero instead ?
> 
> Per current imx-sm, this flags is not used as of now, just a reserved
> flag for future extension. So 0 or 1 does not matter here.
> I will update with Bits[31:0] Reserved.

ok

> 
> >
> >> ++-----------------------+------------------------------------------------------+
> >> +|uint32 resetVectorLow  |Lower vector                                          |
> >> ++-----------------------+------------------------------------------------------+
> >> +|uint32 resetVectorHigh |Higher vector                                         |
> >> ++-----------------------+------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if LM successfully powers on.                     |
> >
> >...typo ?...
> 
> "If reset vector is set successfully"
> 
> >
> >> +|                  |NOT_FOUND: if lmId not points to a valid logical machine,  |
> >> +|                  |or cpuId is not valid.
> >> +|                  |INVALID_PARAMETERS: if reset vector is invalid.            |
> >> +|                  |DENIED: if the agent does not have permission to set the   |
> >> +|                  |the reset vector for the CPU in the LM.                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +NEGOTIATE_PROTOCOL_VERSION
> >> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x10
> >> +protocol_id: 0x80
> >> +
> >> ++--------------------+---------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++--------------------+---------------------------------------------------------+
> >> +|Name                |Description                                              |
> >> ++--------------------+---------------------------------------------------------+
> >> +|uint32 version      |The negotiated protocol version the agent intends to use |
> >> ++--------------------+---------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++--------------------+---------------------------------------------------------+
> >> +|Name                |Description                                              |
> >> ++--------------------+---------------------------------------------------------+
> >> +|int32 status        |SUCCESS: if the negotiated protocol version is supported |
> >> +|                    |by the platform. All commands, responses, and            |
> >> +|                    |notifications post successful return of this command must|
> >> +|                    |comply with the negotiated version.                      |
> >> +|                    |NOT_SUPPORTED: if the protocol version is not supported. |
> >> ++--------------------+---------------------------------------------------------+
> >> +
> >> +Notifications
> >> +_____________
> >> +
> >> +LMM_EVENT
> >> +~~~~~~~~~
> >> +
> >> +message_id: 0x0
> >> +protocol_id: 0x80
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 lmid       |Identifier for the LM that caused the transition.          |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 eventlm    |Identifier for the LM the event is for.                    |
> >
> >So this is the LM that the event refer to ? i.e. this LM eventlm is the
> >one that is booting/resetting/shutdown ? 
> >if this is the case, maybe better as:
> >
> >	"Identifier of the LM this event refers to."
> 
> Thanks, will update as you suggest.
> 

ok

> >
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 flags      |LM events:                                                 |
> >> +|                  |Bits[31:3] Reserved, must be zero.                         |
> >> +|                  |Bit[3] Wake (resume) event:                                |
> >> +|                  |1 LM has awakened.                                         |
> >> +|                  |0 not a wake event.                                        |
> >> +|                  |Bit[2] Suspend (sleep) event:                              |
> >> +|                  |1 LM has suspended.                                        |
> >> +|                  |0 not a suspend event.                                     |
> >> +|                  |Bit[1] Shutdown (off) event:                               |
> >> +|                  |1 LM has shutdown.                                         |
> >> +|                  |0 not a shutdown event.                                    |
> >> +|                  |Bit[0] Boot (on) event:                                    |
> >> +|                  |1 LM has booted.                                           |
> >> +|                  |0 not a boot event.                                        |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >>  SCMI_BBM: System Control and Management BBM Vendor Protocol
> >>  ==============================================================
> >>  
> >> @@ -436,6 +891,288 @@ protocol_id: 0x81
> >>  |                  |0 no button change detected.                               |
> >>  +------------------+-----------------------------------------------------------+
> >>  
> >> +SCMI_CPU: System Control and Management CPU Vendor Protocol
> >> +==============================================================
> >> +
> >> +This protocol allows an agent to start or stop a CPU. It is used to manage
> >> +auxiliary CPUs in an LM (e.g. additional cores in an AP cluster or
> >> +Cortex-M cores).
> >> +Note: For cores in AP cluster, ATF will use CPU protocol to handle them.
> >
> >So this is sort of a PSCI-by-proxy in which you ask the server to turn
> >on/off some of the LM CPUs ?
> 
> Yes. A55 cores are in one LM, so in ATF one A55 use cpu protocol to manage other
> A55 cores.
> 
> >
> >First question would be is not enough to just ask for a specific LM to
> >be booted with LMM ? or add to the LMM protocol a way to specifiy the
> 
> LMM is a large scope, CPU could be inside LMM.
> 
> >'level' of boot that you ask for an LM...I may miss many details but it
> >seems to me a bit odd that you are allowd to ask, from the agent that
> >could have just requested an LM to boot to have some CPUs ON or OFF...
> >...and specify the boot/resume address vectors here to use when turning
> >ON...
> 
> There is case the M7 and A55 are in the same LM, so in such case, if A55 core
> needs to manage M7, need use CPU protocol.
> 
> If A55 and M7 are in two separate LMs, A55 needs use LMM protocol to manage
> M7 LM.
> 

this is a sort of remoteproc-like via SCMI

> >
> >Maybe a bit more of explanation of the rationale and expectations here
> >could help understanding the differet needs from LMM
> 
> There are some internal discussion between NXP and ARM if you search
> your mail "NXP-ARM SCMI OEM extension".
> 
> I could not post them all here.
> 

ok

> >
> >> +
> >> +The CPU protocol provides functions to:
> >> +
> >> +- Describe the protocol version.
> >> +- Discover implementation attributes.
> >> +- Discover the CPUs defined in the system.
> >> +- Start a CPU.
> >> +- Stop a CPU.
> >> +- Set the boot and resume addresses for a CPU.
> >> +- Set the sleep mode of a CPU.
> >> +- Configure wake-up sources for a CPU.
> >> +- Configure power domain reactions (LPM mode and retention mask) for a CPU.
> >> +- The CPU IDs can be found in the CPU section of the SoC DEVICE: SM Device
> >> +  Interface. They can also be found in the SoC RM. See the CPU Mode Control
> >> +  (CMC) list in General Power Controller (GPC) section.
> >> +
> >> +CPU settings are not aggregated and setting their state is normally exclusive
> >> +to one client.
> >> +
> >> +Commands:
> >> +_________
> >> +
> >> +PROTOCOL_VERSION
> >> +~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x0
> >> +protocol_id: 0x82
> >> +
> >> ++---------------+--------------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++---------------+--------------------------------------------------------------+
> >> +|Name           |Description                                                   |
> >> ++---------------+--------------------------------------------------------------+
> >> +|int32 status   | See ARM SCMI Specification for status code definitions.      |
> >> ++---------------+--------------------------------------------------------------+
> >> +|uint32 version | For this revision of the specification, this value must be   |
> >> +|               | 0x10000.                                                     |
> >> ++---------------+--------------------------------------------------------------+
> >> +
> >> +PROTOCOL_ATTRIBUTES
> >> +~~~~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x1
> >> +protocol_id: 0x82
> >> +
> >> ++---------------+--------------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      | See ARM SCMI Specification for status code definitions.   |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 attributes |Protocol attributes:                                       |
> >> +|                  |Bits[31:16] Reserved, must be zero.                        |
> >> +|                  |Bits[15:0] Number of CPUs                                  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +PROTOCOL_MESSAGE_ATTRIBUTES
> >> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x2
> >> +protocol_id: 0x82
> >> +
> >> ++---------------+--------------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: in case the message is implemented and available  |
> >> +|                  |to use.                                                    |
> >> +|                  |NOT_FOUND: if the message identified by message_id is      |
> >> +|                  |invalid or not implemented                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 attributes |Flags that are associated with a specific function in the  |
> >> +|                  |protocol. For all functions in this protocol, this         |
> >> +|                  |parameter has a value of 0                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +CPU_ATTRIBUTES
> >> +~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x4
> >> +protocol_id: 0x82
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 cpuid      |Identifier for the CPU                                     |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if valid attributes are returned successfully.    |
> >> +|                  |NOT_FOUND: if the cpuid is not valid.                      |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 attributes |Bits[31:0] Reserved, must be zero                          |
> >> ++------------------+-----------------------------------------------------------+
> >> +|char name[16]     |NULL terminated ASCII string with CPU name up to 16 bytes  |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +CPU_START
> >> +~~~~~~~~~
> >> +
> >> +message_id: 0x4
> >> +protocol_id: 0x82
> >> +
> >
> >Any constraint to call this only after having successfully called RESET_VECROR_SET ?
> 
> No constraint, if not called RESET_VECROR_SET, it will use default value 0.
> 
> >
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 cpuid      |Identifier for the CPU                                     |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if the cpu is started successfully.               |
> >> +|                  |NOT_FOUND: if cpuid is not valid.                          |
> >> +|                  |DENIED: the calling agent is not allowed to start this CPU.|
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +CPU_STOP
> >> +~~~~~~~~
> >> +
> >> +message_id: 0x5
> >> +protocol_id: 0x82
> >> +
> >> ++------------------+-----------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|uint32 cpuid      |Identifier for the CPU                                     |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++------------------+-----------------------------------------------------------+
> >> +|Name              |Description                                                |
> >> ++------------------+-----------------------------------------------------------+
> >> +|int32 status      |SUCCESS: if the cpu is started successfully.               |
> >> +|                  |NOT_FOUND: if cpuid is not valid.                          |
> >> +|                  |DENIED: the calling agent is not allowed to stop this CPU. |
> >> ++------------------+-----------------------------------------------------------+
> >> +
> >> +CPU_RESET_VECTOR_SET
> >> +~~~~~~~~~~~~~~~~~~~~
> >> +
> >> +message_id: 0x6
> >> +protocol_id: 0x82
> >> +
> >> ++----------------------+-------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Name                  |Description                                            |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 cpuid          |Identifier for the CPU                                 |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 flags          |Reset vector flags:                                    |
> >> +|                      |Bit[31] Resume flag.                                   |
> >> +|                      |Set to 1 to update the reset vector used on resume.    |
> >> +|                      |Bit[30] Boot flag.                                     |
> >> +|                      |Set to 1 to update the reset vector used for boot.     |
> >> +|                      |Bits[29:1] Reserved, must be zero.                     |
> >> +|                      |Bit[0] Table flag.                                     |
> >> +|                      |Set to 1 if vector is the vector table base address.   |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 resetVectorLow |Lower vector:                                          |
> >> +|                      |If bit[0] of flags is 0, the lower 32 bits of the      |
> >> +|                      |physical address where the CPU should execute from on  |
> >> +|                      |reset. If bit[0] of flags is 1, the lower 32 bits of   |
> >> +|                      |the vector table base address                          |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 resetVectorhigh|Upper vector:                                          |
> >> +|                      |If bit[0] of flags is 0, the upper 32 bits of the      |
> >> +|                      |physical address where the CPU should execute from on  |
> >> +|                      |reset. If bit[0] of flags is 1, the upper 32 bits of   |
> >> +|                      |the vector table base address                          |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Name                  |Description                                            |
> >> ++----------------------+-------------------------------------------------------+
> >> +|int32 status          |SUCCESS: if the CPU reset vector is set successfully.  |
> >> +|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
> >> +|                      |INVALID_PARAMETERS: the requested vector type is not   |
> >> +|                      |supported by this CPU.                                 |
> >> +|                      |DENIED: the calling agent is not allowed to set the    |
> >> +|                      |reset vector of this CPU                               |
> >> ++----------------------+-------------------------------------------------------+
> >> +
> >> +CPU_SLEEP_MODE_SET
> >> +~~~~~~~~~~~~~~~~~~
> >> +message_id: 0x7
> >> +protocol_id: 0x82
> >> +
> >> ++----------------------+-------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Name                  |Description                                            |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 cpuid          |Identifier for the CPU                                 |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 flags          |Sleep mode flags:                                      |
> >> +|                      |Bits[31:1] Reserved, must be zero.                     |
> >> +|                      |Bit[0] IRQ mux:                                        |
> >> +|                      |If set to 1 the wakeup mux source is the GIC, else if 0|
> >> +|                      |then the GPC                                           |
> >
> >What is the GPC in this context ?
> 
> General Power Controller.
> 
> >
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 sleepmode      |target sleep mode                                      |
> >
> >What values can this assume ? Is there any predefined sleep value here ?
> 
> From imx-sm, the define is hardware related. I could list in next version.
> 
> #define CPU_SLEEP_MODE_RUN      0U
> #define CPU_SLEEP_MODE_WAIT     1U
> #define CPU_SLEEP_MODE_STOP     2U
> #define CPU_SLEEP_MODE_SUSPEND  3U
> 
> RUN, WAIT, STOP, SUSPEND is GPC concept. it means when wfi, the GPC will
> do what action.
> 
> >
> >> ++----------------------+-------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Name                  |Description                                            |
> >> ++----------------------+-------------------------------------------------------+
> >> +|int32 status          |SUCCESS: if the CPU sleep mode is set successfully.    |
> >> +|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
> >> +|                      |INVALID_PARAMETERS: the sleepmode or flags is invalid. |
> >> +|                      |DENIED: the calling agent is not allowed to configure  |
> >> +|                      |the CPU                                                |
> >> ++----------------------+-------------------------------------------------------+
> >> +
> >> +CPU_INFO_GET
> >> +~~~~~~~~~~~~
> >> +message_id: 0xC
> >> +protocol_id: 0x82
> >> +
> >> ++----------------------+-------------------------------------------------------+
> >> +|Parameters                                                                    |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Name                  |Description                                            |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 cpuid          |Identifier for the CPU                                 |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Return values                                                                 |
> >> ++----------------------+-------------------------------------------------------+
> >> +|Name                  |Description                                            |
> >> ++----------------------+-------------------------------------------------------+
> >> +|int32 status          |SUCCESS: if valid attributes are returned successfully.|
> >> +|                      |NOT_FOUND: if the cpuid is not valid.                  |
> >> ++----------------------+-------------------------------------------------------+
> >> +|uint32 runmode        |Run mode for the CPU                                   |
> >
> >What are the possible runmode values ?
> 
> #define CPU_RUN_MODE_START      0U // start cpu
> #define CPU_RUN_MODE_HOLD       1U // power up and hold cpu
> #define CPU_RUN_MODE_STOP       2U // reset and hold cpu
> #define CPU_RUN_MODE_SLEEP      3U // in cpuidle
> 
> Appreciate for detailed reviewing on the documentation.
> 

Thanks,
Cristian

