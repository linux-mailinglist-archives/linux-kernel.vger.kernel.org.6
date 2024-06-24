Return-Path: <linux-kernel+bounces-227961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650F79158C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE211C22EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332C1A08C4;
	Mon, 24 Jun 2024 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ov/60meu"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697641A08BC;
	Mon, 24 Jun 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264089; cv=none; b=gFwFQXZXKSvL+ys3M+sfKwMsB00SiHgZy8sfvgrVW2NvXXIdGN5DhyskQMghA2zAHtR5f7Q/OF/y1kBHNyHmwUQ+M2k+TNGei/zTw0wNf/vj4OLApbiyxW8LmZElzE1FJHAA98oM3Z22JjhPGcfIv9pTwh2WFOXoeCaE7EDmq7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264089; c=relaxed/simple;
	bh=irpaptYDVwkRaCNdV7yrDMA5ELpgSIooZG+nQu0NVSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ACkRqAqAnoDyoCbHMOBh/w7XBIu5O1oHPabxkPsVX4R4CkwazK0GJdT31qxt1EVrasGPv9AV6JUCrY0dooNSHRCrXJ9o1xz+abH3nc5w1sLcZdpHSn3xlg06/WJXZgKMPblkG0BHV2X+jrvVTvSXdA6RPiREoKJH83Pw/XgE6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ov/60meu; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D464F1BF203;
	Mon, 24 Jun 2024 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719264084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S8IZwJ0ZKIbmEXea9LL/+cvNYFqXpFASQ2x1kGqhifw=;
	b=Ov/60meujivFjPlHv4flQlGHOMb5LyJY7umMDfQLZ9WIIt+YdivmrWKT3K07dus9doKIZb
	RrFM5XVI/w3A0HtoCISKbbhSgwhUpxJ23llk29/+FWS643FyrOwMG+LOaeNfp4+wm+Zhzf
	7nyJzYrsaW7qCHp4Af2UCXTHCKsfSW2YHssrygkGGNUn9JL+iAnSfd+Gs9qA23nm/COzud
	KTw6bgX1j0HuOz014p9oS9yBJA5VeBI8mh1fOPm1pHh2KUvzA0y+Tfr5gYBow4aQ5kftO5
	A5kYfFfXpmjwkCG6kp8xaJqI0X113Pj9ysDllzRyfYwf5S8QIvgQrI/Sq9fE2A==
Date: Mon, 24 Jun 2024 23:21:22 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Conor Dooley  <conor@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Bartosz  Golaszewski <brgl@bgdev.pl>, Saravana Kannan
 <saravanak@google.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?Herv?=
 =?UTF-8?Q?=C3=A9?= Codina  <herve.codina@bootlin.com>, Thomas  Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Fixing property memory leaks on device tree overlay removal
Message-ID: <20240624232122.3cfe03f8@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

device tree overlays are implemented in the kernel since a long time,
but there is currently no code using them, except unittest. The
largest (in terms of code lines involved) blocker for enabling it is the
memory leak of properties that happen on overlay removal [0]. The
kernel warns about it on overlay insertion:

  OF: overlay: WARNING: memory leak will occur if overlay removed, property=
: /...

We are working on a driver for a proprietary connector allowing a device
to connect to an add-on board adding new non-discoverable hardware, and
the driver is based on overlays. This has been discussed during ELC last
April [1] and I sent a patch series implementing it in May [2].

The property memory leak topic was mentioned but we haven't addressed
the detail so far. This e-mail is meant to present our proposed plan
to fix it.

Receiving comments from the kernel community would be very valuable
given the amount of work involved.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Problem description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In the kernel every 'struct device_node' is refcounted so the OF core
knows when to free it. There are of course get/put imbalance bugs
around, but these are "just" bugs that need to be fixed as they are
found.

On the other hand, there is no refcounting for 'struct property'. Yet
some of the internal kernel APIs to access properties, e.g.
of_property_read_string(), return either a 'struct property' pointer or
a copy of the 'char *value' field. This is not a bug, it is an API
design flaw: any user (e.g. any OF driver) can take a pointer to
property data that was allocated and should be deallocated by the OF
core, but the OF core has no idea of when that pointer will stop being
used.=20

Now, when loading a DT overlay there are three possible cases:

 1. both the property and the containing node are in the base tree
 2. both the property and the containing node are in the same overlay
 3. the property is in an overlay and the containing node is either
    in the base tree or in a previously-loaded overlay

Cases 1 and 2 are not problematic. In case 1 the data allocated for the
properties is never removed. In case 2 the properties are removed when
removing the parent node, which gets removed when removing the overlay
thanks to 'struct device_node' refcounting, based on the assumption
that the property lifetime is a subset of the parent node lifetime. The
problem exists in case 3. Properties in case 3 are usually a small part
of all the properties but there can be some (and there are some in the
product we are working on), and that's what needs to be addressed.

The kernel just doesn't know when to release these property structures,
so the OF core code currently stores the properties loaded by overlays
in a "deadprops" list within the parent node. They will be freed when
the node itself is freed (based on node refcounting) in order to be
safe. However it means they are memory leaks for case 3, where the node
can be never removed.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Approach 1: adding property refcount
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The first option we considered is the obvious one: adding a refcount to
'struct property'. However this does not look like a very good solution
as every user of a DT property in the kernel would need to put the
property after getting and using it: this is already cumbersome and
error-prone for nodes, and properties are usually many more than nodes.
Besides it would add a memory and execution overhead to all properties,
while only a small fraction is affected.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Approach 2: change the property APIs to not return pointers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

So we went back to the API design flaw and thought what API we would
invent if we had to start from scratch now with the laodable overlay
requirement in mind. We concluded the property API should just not
return any pointer to 'struct property' or one of its fields. In other
words, this is internal data of the OF core.

We think the API to access DT properties should instead do one of these:

 1. check whatever is needed and return the outcome, not the internal
    data, e.g. like of_property_match_string()
 2. if that is not possible, return a copy of the property value, that
    the called will be responsible of, and which can outlive the struct
    property if that make sense

With this approach, it becomes safe to remove the overlay at any moment
_unless_ one of these API functions is currently executing on any CPU
core. To ensure there is no race condition we need a lock, probably
using rwsem or RCU, to guard the APIs accessing properties. This can be
coarse-grained (one global lock, or one lock per changeset) and needs no
cooperation from callers, being all managed by the OF core.

So this is is the option we plan to take.

~~~~~~~~~~~~~~~~~~~~~~~
Accessor classification
~~~~~~~~~~~~~~~~~~~~~~~

We examined and classified the various APIs that allow accessing the OF
properties, which we called accessors, and counted their call sites.

There are three kinds of property accessor functions in the OF APIs
that need to be fixed:

 1. classic accessors
 2. for_each loop macros and supporting functions
 3. OF reconfig notifiers

-----------------
Classic accessors
-----------------

Classic accessors are those that return some property value. Examples
include:

  of_find_property()
  of_property_read_string()
  of_get_property()
  of_property_read_string_index()

Classic accessors have lots of call sites: we counted about 1900. Many
are in drivers and will need to be addressed individually, one by one.
So the plan is to add new "safe" accessors and progressively convert
drivers and other call sites to use them, to eventually remove the
current unsafe accessors.

One supporting strategy in that direction is making 'struct property'
opaque, which would ensure its fields just cannot be accessed directly.
I attempted it and the amount of code that gets broken and needs to be
fixed is "manageable".

An even stronger strategy is to move struct property completely outside
in-kernel public include files (i.e. from include/linux/of.h to
drivers/of/of_private.h) so even struct property pointer cannot exist
anymore outside of the OF core. However this is quite extreme and very
hard to apply (see the section about for_each loops).

---------------------------------------------
for_each loop macros and supporting functions
---------------------------------------------

Fixing the for_each iterators (about 140 call sites) is hard because
they use 'struct property' pointers "internally", but being macros the
iterarot is exposed to code using those macros. So we propose a
mitigation strategy that is more approachable and a removal strategy.

The mitigation strategy is based on the declaring variables in the for
loop init clause, as allowed since the kernel has moved to C gnu11.
This would allow replacing typical code like:

  struct device_node *node =3D <...>;
  struct property *prop;
  const __be32 *cur;
  u32 rate;

  of_property_for_each_u32(node, "my-property", prop, cur, rate) {

with code like:

  struct device_node *node =3D <...>;
  u32 rate;

  of_property_for_each_u32(node, "my-property", rate) {

This is only a mitigation strategy because it would not strictly forbid
access to the struct property and the __be32 variables. But it would
make it less easy and much more visible to code reviewers and possibly
checkpatch, and as such it would make it hard to add my mistake. It
also makes code simpler and more readable so it is an overall
improvement as well.

This is simple to implement and at first glance about half of the call
sites can benefit. For those which cannot, an ad-hoc solution must be
devised, possibly based on a full array copy as a last resort.

The removal strategy involves a total removal of these looping macros,
in lack of a way to implement them without giving access to the
property and iterator pointers. Removal of these APIs would involve
replacing them with specific accessors that internally loop and do what
is needed (for common cases) or return a full copy for other cases.
Passing a callback for the looping function to operate on members is
also potentially doable but cumbersome for callers.

Instead of the removal strategy I think there might be better tools,
but I still haven't done a real evaluations so far.

Note that if struct property were made internal, the removal strategy
would become unavoidable.

---------------------
OF reconfig notifiers
---------------------

Reconfig notifiers are callbacks that can be enabled in order to be
notified of changes to the device tree. The APIs themselves are not
leaking internal pointers, but the notifier callbacks are passed a
'struct of_reconfig_data *' parameter which contains pointers to the
old and new struct property pointers.

If struct property were opaque this would not expose pointers to
property name/len/value. Still the struct property pointer would be
exposed. So we propose to make the entire struct of_reconfig_data
opaque.

The drawback is that several new (trivial) accessors would be needed to
get the data from such an opaque structure. However call sites of
notifiers are limited (about 10), some don=E2=80=99t even access properties=
 at
all and others appear to use them carefully, so a fix would be
relatively simple to do.

~~~~~~~~~~~~~~~
Transition plan
~~~~~~~~~~~~~~~

Transitioning to the new accessors is not going to happen quickly given
the amount of call sites, so we devised a strategy to incrementally
approach it while avoiding introducing new calls to the old APIs.

The transition plan is based on adding a Kconfig symbol (a tentative
name is CONFIG_EXPORT_UNSAFE_OF_ACCESSORS) meaning =E2=80=9Cexport old OF
accessor functions returning pointers to firmware data=E2=80=9D and default=
ing
to =E2=80=98y=E2=80=99 to avoid breaking current usages. When this is set t=
o =E2=80=98n=E2=80=99:

 - The old accessors returning pointers to struct property values are
   not built, or at least not exported outside the OF core
 - So any defconfig with at least one driver using the old accessors
   would just not build, which allows to easily find out what needs to
   be updated if one wants to remove overlays in their specific
   configuration, or to disable unneeded drivers that are not yet
   updated
 - The property leaks under discussion are not possible anymore
 - The deadprops list and the warning are not built
 - Note: we need to ensure automated test bots won=E2=80=99t set this setti=
ng
   to =E2=80=98n=E2=80=99 or they will fail

Any code using DT overlays, including the connector driver proposed in
[2], can depend on CONFIG_EXPORT_UNSAFE_OF_ACCESSORS=3Dn, to ensure the
leaking APIs are never called when runtime-loadable overlays are in use.

Preventing new usages of old accessors will be important. Tools to
achieve that:

 * Extend checkpatch to report an error on their usage
 * Add a 'K:' entry to MAINTAINERS so that patches trying to use them
   will be reported (to me at least)

Once all call sites are updated to the new API, the old API can be
removed entirely along with the deadprops list and the
CONFIG_EXPORT_UNSAFE_OF_ACCESSORS Kconfig symbol.

=3D=3D=3D=3D=3D=3D=3D
Roadmap
=3D=3D=3D=3D=3D=3D=3D

We plan to address this in various steps, in order to allow an easier
review process and to have the various changes tested progressively.

The main steps in our roadmap are:

 1. Make struct property opaque and fix code that gets broken
 2. Main API transition (class 1):
    - Add new safe accessors
    - Implement CONFIG_EXPORT_UNSAFE_OF_ACCESSORS to hide leaking
      accessors
    - Document the above
    - OF implementation
    - fwnode wrapper (for ACPI+SWNODE)
    - rwsem/RCU synchronisation mechanism
    - convert a few drivers
 3. Prevent new patches using old accessors from being merged
    (checkpatch, MAINTAINERS...)
 4. Convert a significant number of drivers (enough to support a
    complex SoC)
 5. for_each loops (class 2) mitigation strategy
 6. Make struct of_reconfig_data opaque (class 3)
 7. for_each loops (class 2) full removal strategy

We think the necessity of the last two step is subject to discussion,
while all the previous ones are required.

Note there is no "convert all call sites" in the plan. The amount of
drivers alone is huge, and converting all of them would not be doable
entirely by us both in terms of amount of work and for lack of hardware
to test the changes.

However we plan to convert many drivers and we will be glad to support
the community in fixing the existing code, as well as in avoiding new
code using old accessors to be accepted.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Conclusion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So, that's our proposed plan. As stated, any comment will be
appreciated. This includes both (hopefully constructive) criticism and
positive feedback. This would mean starting a relevant work with a good
assurance that the approach is approved by the relevant kernel
maintainers.

Best regards,
Luca

[0] https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts#issues_and_what_=
needs_to_be_completed_--_Not_an_exhaustive_list
[1] https://lore.kernel.org/all/20240426115141.201f257a@booty/
[2] https://lore.kernel.org/all/20240510-hotplug-drm-bridge-v2-0-ec32f2c66d=
56@bootlin.com/

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

